# Dayvd Costa Personal Portfolio Design

## Goal

Build a portable, single-page personal portfolio for Dayvd Costa as one standalone
`index.html` file. The page targets international remote software engineering and
AI product engineering roles. All visible copy is in English.

## Factual Content Rules

- Present Dayvd Costa as a Software Engineer and AI Product Engineer based in Rio
  de Janeiro, Brazil, available for remote work.
- Describe three work engagements in a vertical timeline:
  - Intentus Digital, full-time, February 2024 to present. Dayvd acts as Tech Lead
    and Software Engineer while building dotless, a financial-advisory platform.
  - Clip Fy, temporary, January 2025 to May 2026. Dayvd shipped the AI video SaaS
    MVP, processing pipeline, backend reliability work, monetization, and cloud
    deployment.
  - Realtor, full-time and on-site, January 2022 to January 2024. Dayvd delivered
    full-stack features for a real-estate brokerage platform.
- Render `dotless` as a linked project label inside the Intentus Digital entry,
  not as a separate employer. It may have its own replaceable logo placeholder.
- Never claim that Dayvd founded, owns, or created the companies or projects.
  Describe his role and the systems he built.
- Include the supplied education, languages, contact details, and skills without
  inventing certifications, links, metrics, or employers.

## Visual Direction

Use a restrained notebook aesthetic: a neutral paper-like background, subtle
ruled-line details, modest shadows, and the `Architects Daughter` font. The result
must remain professional and easy to scan. The supplied `:root` and `.dark`
variables are the source of truth for colors, typography, shadows, radius, and
letter spacing.

The layout is mobile-first and editorial:

1. A sticky, compact top navigation with section links and a light/dark toggle.
2. An airy hero with name, role, profile statement, remote location, and contact
   actions.
3. A short about section.
4. A vertical experience timeline with logo placeholders and linked company or
   project names.
5. Skills grouped into compact icon-and-name chips.
6. Education and languages in a restrained two-column section on wider screens.
7. A contact footer with email, phone, LinkedIn, and GitHub actions.

Avoid decorative excess: no oversized marketing hero, nested cards, gradients,
or ornamental blobs.

## Technical Architecture

Create one `index.html` containing semantic HTML, Tailwind CDN configuration,
custom CSS, and vanilla JavaScript. External runtime resources are limited to
CDNs:

- Tailwind browser CDN for utility classes.
- Google Fonts for `Architects Daughter`.
- Lucide CDN for interface icons.
- Simple Icons CDN URLs for technology chips.

The page remains readable if JavaScript or a technology icon fails to load.
Technology icons use monochrome Simple Icons URLs with `505050` for light mode
and `dcdcdc` for dark mode. Each icon has a visible text label, `alt`, and
`aria-label`. Technologies without a dependable Simple Icons slug use a Lucide
generic icon or text-only chip.

## Interaction And Accessibility

- The light/dark toggle updates the root `.dark` class, stores the preference in
  `localStorage`, and falls back to the operating-system preference.
- Lucide icons initialize after `DOMContentLoaded`.
- Section navigation uses anchors and a visible keyboard focus style.
- Icon-only links have `aria-label` text.
- Logo placeholders have accessible labels and comments marking where hosted
  logo image URLs should be inserted.
- A small `IntersectionObserver` progressively reveals sections with subtle
  fade-and-slide transitions. Respect `prefers-reduced-motion`.

## Placeholder Strategy

Keep `href="#"` placeholders for LinkedIn, GitHub, company, project, and logo
destinations. Add concise HTML comments immediately beside each replaceable
link or logo so hosted URLs can be inserted later without searching through the
document.

## Verification

After implementation:

- Check standalone HTML structure and required sections with command-line
  searches.
- Open the artifact in a browser at desktop and mobile viewport sizes.
- Confirm light/dark mode, navigation, scroll reveals, icon rendering, fallback
  behavior, visible focus styles, and absence of overflow or text overlap.
