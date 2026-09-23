#!/usr/bin/env python3
"""Check version agreement and links between tracked policy documents."""

from pathlib import Path
import re
from urllib.parse import unquote


ROOT = Path(__file__).resolve().parents[1]
version = (ROOT / "VERSION").read_text(encoding="utf-8").strip()
assert re.fullmatch(r"\d+\.\d+\.\d+", version), "VERSION must be semantic"
major_minor = ".".join(version.split(".")[:2])

expected = {
    "AGENTS.md": f"Adopted: engineering-standard {version}",
    "AGENT_BOOTSTRAP.md": f"({version} = Universal Software Engineering Standard {major_minor}",
    "UNIVERSAL_SOFTWARE_ENGINEERING_STANDARD.md": f"**Version:** {major_minor}",
    "TEAM_DEVELOPMENT_OPERATING_POLICY.md": f"**Version:** {major_minor}",
    "CHANGELOG.md": f"## {version} (",
}
for name, marker in expected.items():
    assert marker in (ROOT / name).read_text(encoding="utf-8"), (
        f"{name} does not refer to policy version {version}"
    )

errors = []
for document in ROOT.rglob("*.md"):
    if ".git" in document.parts:
        continue
    content = document.read_text(encoding="utf-8")
    # Local Markdown links are checked without fetching external pages.
    for target in re.findall(r"!?\[[^\]]*\]\(([^)]+)\)", content):
        target = target.split("#", 1)[0].split(" ", 1)[0]
        if not target or target.startswith(("https:", "http:", "mailto:", "data:")):
            continue
        if not (document.parent / unquote(target)).exists():
            errors.append(f"{document.relative_to(ROOT)}: missing link {target}")

if errors:
    raise SystemExit("\n".join(errors))
print(f"Policy {version}: versions agree and local Markdown links resolve")
