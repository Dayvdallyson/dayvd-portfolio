#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HTML="$ROOT_DIR/index.html"

fail() {
  printf 'FAIL: %s\n' "$1" >&2
  exit 1
}

require_text() {
  local pattern="$1"
  local message="$2"
  rg -q --fixed-strings -- "$pattern" "$HTML" || fail "$message"
}

require_regex() {
  local pattern="$1"
  local message="$2"
  rg -q -- "$pattern" "$HTML" || fail "$message"
}

reject_text() {
  local pattern="$1"
  local message="$2"
  if rg -q --fixed-strings -- "$pattern" "$HTML"; then
    fail "$message"
  fi
}

[[ -f "$HTML" ]] || fail "index.html is missing"

require_regex 'id="about"' "about section is missing"
require_regex 'id="experience"' "experience section is missing"
require_regex 'id="skills"' "skills section is missing"
require_regex 'id="education"' "education section is missing"
require_regex 'id="contact"' "contact footer is missing"

require_text 'Intentus Digital' "Intentus Digital experience is missing"
require_text 'Building' "dotless must be described as work built during Intentus Digital"
require_text '>dotless</a>' "dotless project label is missing"
require_text 'Clip Fy' "Clip Fy experience is missing"
require_text 'Realtor' "Realtor experience is missing"
require_text 'B.Sc. in Computer Science' "education details are missing"
require_text 'English' "English language entry is missing"
require_text 'Portuguese' "Portuguese language entry is missing"

require_text '--background: #f9f9f9;' "light theme variables are missing"
require_text '--background: #2b2b2b;' "dark theme variables are missing"
require_text 'https://cdn.tailwindcss.com' "Tailwind CDN is missing"
require_text 'https://unpkg.com/lucide@latest' "Lucide CDN is missing"
require_text 'https://cdn.simpleicons.org/python/505050/dcdcdc' "Simple Icons monochrome URL is missing"
require_text '<span>AWS S3</span>' "AWS fallback chip is missing"
require_text '<span>DocuSign</span>' "DocuSign fallback chip is missing"
reject_text 'https://cdn.simpleicons.org/amazonwebservices/' "removed AWS Simple Icons slug must use fallback"
reject_text 'https://cdn.simpleicons.org/docusign/' "removed DocuSign Simple Icons slug must use fallback"

require_text 'aria-label="Toggle color theme"' "theme toggle must have an accessible label"
require_text 'aria-label="Email Dayvd Costa"' "email action must have an accessible label"
require_text 'aria-label="Call Dayvd Costa"' "phone action must have an accessible label"
require_text 'aria-label="Dayvd Costa on LinkedIn"' "LinkedIn action must have an accessible label"
require_text 'aria-label="Dayvd Costa on GitHub"' "GitHub action must have an accessible label"
require_regex 'alt="[^"]+"' "technology icons must have alt text"
require_regex 'aria-label="[^"]+"' "interactive icons must have accessible labels"

require_text "localStorage.setItem('theme'" "theme choice must persist"
require_text "window.matchMedia('(prefers-color-scheme: dark)')" "theme must honor system preference"
require_text 'new IntersectionObserver' "scroll reveal observer is missing"
require_text 'lucide.createIcons()' "Lucide initialization is missing"
require_text 'prefers-reduced-motion' "reduced motion support is missing"
require_text 'onerror="handleTechIconError(this)"' "technology icon failure fallback is missing"

python3 - "$HTML" <<'PY'
from html.parser import HTMLParser
from pathlib import Path
import sys


class PortfolioParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.ids = []
        self.simple_icons = []
        self.logo_placeholders = 0

    def handle_starttag(self, tag, attrs):
        attributes = dict(attrs)
        if "id" in attributes:
            self.ids.append(attributes["id"])
        classes = attributes.get("class", "").split()
        if "logo-placeholder" in classes:
            self.logo_placeholders += 1
        src = attributes.get("src", "")
        if tag == "img" and src.startswith("https://cdn.simpleicons.org/"):
            self.simple_icons.append(attributes)


parser = PortfolioParser()
parser.feed(Path(sys.argv[1]).read_text(encoding="utf-8"))

required_ids = {"top", "about", "experience", "skills", "education", "contact", "theme-toggle"}
missing_ids = required_ids.difference(parser.ids)
if missing_ids:
    raise SystemExit(f"FAIL: missing HTML ids: {sorted(missing_ids)}")
if len(parser.ids) != len(set(parser.ids)):
    raise SystemExit("FAIL: duplicate HTML id found")
if parser.logo_placeholders != 3:
    raise SystemExit(f"FAIL: expected 3 logo placeholders, found {parser.logo_placeholders}")
if len(parser.simple_icons) < 20:
    raise SystemExit(f"FAIL: expected at least 20 Simple Icons images, found {len(parser.simple_icons)}")
for icon in parser.simple_icons:
    if not icon.get("alt") or not icon.get("aria-label"):
        raise SystemExit(f"FAIL: icon lacks alt or aria-label: {icon.get('src')}")
    if icon.get("onerror") != "handleTechIconError(this)":
        raise SystemExit(f"FAIL: icon lacks error fallback: {icon.get('src')}")
PY

printf 'PASS: portfolio structure verified\n'
