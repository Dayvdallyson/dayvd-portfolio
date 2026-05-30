# Personal Portfolio Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build Dayvd Costa's portable single-page portfolio as one standalone HTML artifact.

**Architecture:** Keep all production markup, styles, and behavior inside `index.html`. Use a shell verifier to assert required content and integration hooks before and after implementation, then inspect the rendered page in a real browser at desktop and mobile sizes.

**Tech Stack:** HTML5, Tailwind browser CDN, custom CSS variables, vanilla JavaScript, Lucide CDN, Simple Icons CDN, Google Fonts.

---

### Task 1: Add Structural Verification

**Files:**
- Create: `tests/verify-portfolio.sh`

- [ ] **Step 1: Write a failing shell verifier**

Create a script that fails if `index.html` is absent, then checks the required
sections, employer/project wording, theme variables, accessibility hooks,
placeholder links, Lucide initialization, dark-mode persistence, reveal
observer, and representative Simple Icons URLs.

- [ ] **Step 2: Run the verifier to confirm the red state**

Run: `bash tests/verify-portfolio.sh`

Expected: failure stating that `index.html` is missing.

### Task 2: Build The Standalone Artifact

**Files:**
- Create: `index.html`

- [ ] **Step 1: Add the document shell**

Embed the supplied light and dark theme variables, Tailwind browser CDN,
Architects Daughter font, Lucide CDN, semantic navigation, and notebook-style
background.

- [ ] **Step 2: Add factual portfolio content**

Add hero, about, three-entry experience timeline, grouped skills, education,
languages, and contact footer. Present dotless only as a platform built while
working at Intentus Digital.

- [ ] **Step 3: Add icon fallbacks and interactions**

Render technology chips with Simple Icons URLs when dependable, Lucide generic
icons or text-only chips otherwise. Add image error fallback, theme persistence,
scroll reveal behavior, and Lucide initialization.

- [ ] **Step 4: Run the verifier to confirm the green state**

Run: `bash tests/verify-portfolio.sh`

Expected: all checks pass.

### Task 3: Inspect In A Real Browser

**Files:**
- Verify: `index.html`

- [ ] **Step 1: Open the local file with Playwright CLI**

Run: `"$PWCLI" open "file:///home/dayvd/Documentos/dayvd-portfolio/index.html"`

- [ ] **Step 2: Capture desktop and mobile screenshots**

Inspect layout hierarchy, theme toggle, responsive behavior, overflow, text
overlap, icon rendering, and the document console.

- [ ] **Step 3: Re-run the structural verifier**

Run: `bash tests/verify-portfolio.sh`

Expected: all checks pass after any visual corrections.
