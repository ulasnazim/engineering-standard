$ErrorActionPreference = 'Stop'
$policyRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$testArea = Join-Path ([System.IO.Path]::GetTempPath()) ('engineering-standard-ci-' + [guid]::NewGuid().ToString('N'))

function Assert-OK([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

try {
    $source = Join-Path $testArea 'source'
    $upstream = Join-Path $testArea 'upstream.git'
    $dest = Join-Path $testArea 'policy'
    $toolRoot = Join-Path $testArea 'toolroot'
    New-Item -ItemType Directory -Path $source, (Join-Path $toolRoot '.claude') -Force | Out-Null

    git -C $source init -q -b smoke
    Assert-OK ($LASTEXITCODE -eq 0) 'Fixture git init failed'
    Copy-Item (Join-Path $policyRoot 'AGENT_BOOTSTRAP.md'), (Join-Path $policyRoot 'VERSION') $source
    git -C $source add AGENT_BOOTSTRAP.md VERSION
    git -C $source -c user.name=PolicySmoke -c user.email=ci@example.invalid commit -qm 'Disposable installer fixture'
    Assert-OK ($LASTEXITCODE -eq 0) 'Fixture commit failed'
    git init -q --bare $upstream
    git -C $source push -q $upstream 'HEAD:refs/heads/smoke'
    Assert-OK ($LASTEXITCODE -eq 0) 'Fixture push failed'
    git --git-dir=$upstream symbolic-ref HEAD refs/heads/smoke
    git clone -q $upstream $dest
    Assert-OK ($LASTEXITCODE -eq 0) 'Fixture clone failed'

    $env:ENG_STANDARD_HOME = $dest
    $env:ENG_STANDARD_TOOL_HOME = $toolRoot
    $claude = Join-Path $toolRoot '.claude/CLAUDE.md'
    [System.IO.File]::WriteAllText($claude, "My existing instructions`n")
    $installer = Join-Path $policyRoot 'install/install.ps1'

    & $installer -All -DryRun | Out-Null
    Assert-OK (-not (Test-Path (Join-Path $toolRoot '.codex/AGENTS.md'))) 'Dry-run wrote a file'
    & $installer -All | Out-Null
    foreach ($path in @('.claude/CLAUDE.md', '.codex/AGENTS.md', '.config/opencode/AGENTS.md')) {
        $content = Get-Content (Join-Path $toolRoot $path) -Raw
        Assert-OK (([regex]::Matches($content, [regex]::Escape('<!-- BEGIN engineering-standard'))).Count -eq 1) "Missing or repeated managed block: $path"
    }
    Assert-OK ((Get-Content $claude -Raw).Contains('My existing instructions')) 'User instructions lost'
    $before = Get-Content (Join-Path $toolRoot '.codex/AGENTS.md') -Raw
    & $installer -All | Out-Null
    Assert-OK ((Get-Content (Join-Path $toolRoot '.codex/AGENTS.md') -Raw) -eq $before) 'Install not idempotent'
    & $installer -Uninstall | Out-Null
    Assert-OK ((Get-Content $claude -Raw).Trim() -eq 'My existing instructions') 'Uninstall lost user instructions'
    Assert-OK (-not (Test-Path (Join-Path $toolRoot '.codex/AGENTS.md'))) 'Uninstall left managed file'
    Write-Host 'PowerShell installer dry-run, install, repeat and uninstall passed'
} finally {
    Remove-Item -Recurse -Force $testArea -ErrorAction SilentlyContinue
}
