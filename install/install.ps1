# Registers the team engineering standard with supported AI coding tools on this
# Windows machine. Equivalent of install.sh.
#
# Usage (PowerShell):
#   .\install.ps1              install or update
#   .\install.ps1 -All         wire all supported tools even if not detected
#   .\install.ps1 -DryRun      show what would change
#   .\install.ps1 -Uninstall   remove everything this script added (keeps the clone)
[CmdletBinding()]
param([switch]$All, [switch]$DryRun, [switch]$Uninstall)
$ErrorActionPreference = 'Stop'

$RepoUrl     = if ($env:ENG_STANDARD_REPO) { $env:ENG_STANDARD_REPO } else { 'git@github.com:ulasnazim/engineering-standard.git' }
$Dest        = if ($env:ENG_STANDARD_HOME) { $env:ENG_STANDARD_HOME } else { Join-Path $HOME '.engineering-standard' }
$ToolRoot    = if ($env:ENG_STANDARD_TOOL_HOME) { $env:ENG_STANDARD_TOOL_HOME } else { $HOME }
$CodexDir    = if ($env:ENG_STANDARD_TOOL_HOME) { Join-Path $ToolRoot '.codex' } elseif ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $ToolRoot '.codex' }
$ClaudeDir   = Join-Path $ToolRoot '.claude'
$OpenCodeDir = Join-Path $ToolRoot '.config\opencode'

$BeginMark = '<!-- BEGIN engineering-standard (managed by install.sh; edits inside are overwritten) -->'
$EndMark   = '<!-- END engineering-standard -->'
$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

function Test-Detected([string]$Command, [string]$Dir) {
    return $All -or [bool](Get-Command $Command -ErrorAction SilentlyContinue) -or (Test-Path $Dir)
}

# Returns the file's lines without the managed block and without trailing blank lines.
function Get-StrippedLines([string]$Path) {
    if (-not (Test-Path $Path)) { return @() }
    $out = New-Object System.Collections.Generic.List[string]
    $skip = $false
    foreach ($line in [System.IO.File]::ReadAllLines($Path)) {
        if ($line -eq $BeginMark) { $skip = $true; continue }
        if ($line -eq $EndMark)   { $skip = $false; continue }
        if (-not $skip) { $out.Add($line) }
    }
    while ($out.Count -gt 0 -and $out[$out.Count - 1].Trim() -eq '') { $out.RemoveAt($out.Count - 1) }
    return ,$out.ToArray()
}

function Set-ManagedBlock([string]$Target, [string[]]$Body) {
    $kept = Get-StrippedLines $Target
    $lines = @()
    if ($kept.Count -gt 0) { $lines += $kept; $lines += '' }
    $lines += $BeginMark; $lines += $Body; $lines += $EndMark
    $newText = ($lines -join "`n") + "`n"
    if ((Test-Path $Target) -and ([System.IO.File]::ReadAllText($Target) -eq $newText)) {
        Write-Host "  unchanged: $Target"; return
    }
    if ($DryRun) { Write-Host "  [dry-run] would update: $Target"; return }
    New-Item -ItemType Directory -Force -Path (Split-Path $Target) | Out-Null
    $backup = "$Target.before-engineering-standard"
    if ((Test-Path $Target) -and -not (Test-Path $backup)) { Copy-Item $Target $backup }
    [System.IO.File]::WriteAllText($Target, $newText, $Utf8NoBom)
    Write-Host "  updated: $Target"
}

function Remove-ManagedBlock([string]$Target) {
    if (-not (Test-Path $Target)) { return }
    if (-not (Select-String -Path $Target -SimpleMatch $BeginMark -Quiet)) { return }
    $kept = Get-StrippedLines $Target
    if ($DryRun) { Write-Host "  [dry-run] would remove block from: $Target"; return }
    if ($kept.Count -gt 0) {
        [System.IO.File]::WriteAllText($Target, (($kept -join "`n") + "`n"), $Utf8NoBom)
        Write-Host "  removed block: $Target"
    } else {
        Remove-Item $Target; Write-Host "  removed file: $Target"
    }
}

if ($Uninstall) {
    Write-Host "Removing engineering-standard wiring (the clone at $Dest is kept)."
    Remove-ManagedBlock (Join-Path $ClaudeDir 'CLAUDE.md')
    Remove-ManagedBlock (Join-Path $CodexDir 'AGENTS.md')
    Remove-ManagedBlock (Join-Path $OpenCodeDir 'AGENTS.md')
    Write-Host 'Done.'; exit 0
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'git is required' }
if (Test-Path (Join-Path $Dest '.git')) {
    Write-Host "Updating $Dest"
    if ($DryRun) { Write-Host '  [dry-run] git pull --ff-only' } else { git -C $Dest pull --ff-only --quiet; if ($LASTEXITCODE) { throw 'git pull failed' } }
} elseif (Test-Path $Dest) {
    throw "$Dest exists but is not a git clone; move it or set ENG_STANDARD_HOME"
} else {
    Write-Host "Cloning $RepoUrl -> $Dest"
    if ($DryRun) { Write-Host '  [dry-run] git clone'; Write-Host 'Dry run: clone not present yet.'; exit 0 }
    git clone --quiet $RepoUrl $Dest; if ($LASTEXITCODE) { throw 'git clone failed' }
}

$Bootstrap = Join-Path $Dest 'AGENT_BOOTSTRAP.md'
if (-not (Test-Path $Bootstrap)) { throw "AGENT_BOOTSTRAP.md not found in $Dest" }
$VersionFile = Join-Path $Dest 'VERSION'
$Version = if (Test-Path $VersionFile) { (Get-Content $VersionFile -Raw).Trim() } else { 'unknown' }
Write-Host "Policy bundle version: $Version"
$Header = "Company engineering policy (bundle $Version). Local copy of the policy files: $Dest"

$ClaudeBody   = @($Header, "@$($Bootstrap -replace '\\','/')")
$EmbeddedBody = @($Header, '') + [System.IO.File]::ReadAllLines($Bootstrap)

$wired = $false
if (Test-Detected 'claude' $ClaudeDir) {
    Write-Host 'Claude Code:'
    Set-ManagedBlock (Join-Path $ClaudeDir 'CLAUDE.md') $ClaudeBody
    $wired = $true
}
if (Test-Detected 'codex' $CodexDir) { Write-Host 'Codex:'; Set-ManagedBlock (Join-Path $CodexDir 'AGENTS.md') $EmbeddedBody; $wired = $true }
if (Test-Detected 'opencode' $OpenCodeDir) { Write-Host 'OpenCode:'; Set-ManagedBlock (Join-Path $OpenCodeDir 'AGENTS.md') $EmbeddedBody; $wired = $true }

if (-not $wired) { Write-Host 'No supported tool detected. Re-run with -All, or paste AGENT_BOOTSTRAP.md into your tool''s global instructions.' }
Write-Host ''
Write-Host 'Other tools (Cursor, Gemini CLI, OpenClaw, etc.): add AGENT_BOOTSTRAP.md to the tool''s global/user rules.'
Write-Host 'Re-run this script after each policy release (Codex/OpenCode copies are embedded, not linked).'
