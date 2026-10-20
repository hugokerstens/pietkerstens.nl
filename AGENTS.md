# Piet Kerstens portfolio

This is a Hugo website for an owner with no coding experience. Keep instructions
and changes approachable. Content is Dutch. Keep the current design unless asked
to change it. There is no Node, Ruby, Go, theme submodule, or CMS dependency.

This repository is the source of truth for the website. Describe it as the
website itself, without references to a previous website, a copy, or a migration.

## Preview and build

- Windows preview: double-click `Preview website.cmd`, or run
  `powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/preview.ps1`.
- Windows build: `powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/hugo.ps1 --minify`.
- Linux/macOS preview: `bash scripts/hugo.sh server --buildDrafts --bind 127.0.0.1 --baseURL http://localhost:1313/`.
- Linux/macOS build: `bash scripts/hugo.sh --gc --minify`.
- The Windows/Linux helpers download a checksum-verified, pinned executable into `.tools/`.
  macOS requires the pinned Hugo version to be installed first.
  First use needs internet access. Later previews work offline.
- Reuse an existing preview server. Drafts appear locally; production excludes them.
- Do not stop the preview during ordinary edits. Before handoff, build production
  and check internal links/images, including a GitHub project path if URL handling changes.

## Editing

- In reader-facing text, workflow names, and owner instructions, call the generator
  "site builder" or refer to the "website" rather than repeating "Hugo", which is
  also the owner's name. Keep the product name where needed for accurate technical
  documentation, commands, filenames, and download URLs.
- Never use em dashes (Unicode U+2014) in any website text, including headings,
  content, metadata, image alt text, and accessibility labels. Do not use HTML
  entities or Markdown substitutions that render as em dashes. Use a comma,
  colon, parentheses, or a separate sentence instead.
- Each artwork: `content/artworks/<slug>/index.md` and its image in the same folder.
- Required fields: title, weight, material, dimensions, image, alt.
- Lower weight appears earlier. Desktop columns distribute sorted artworks by index
  modulo four. Preserve existing metadata unless asked.
- Start a new artwork with `hugo new content artworks/<slug> --kind artworks`,
  using the project helper in place of `hugo`. Copy the image into that folder,
  set its filename and meaningful Dutch alt text, then preview it.
- Posts: `content/posts/<slug>/index.md`, with optional images in the same folder.
  Use `hugo new content posts/<slug> --kind posts`. Templates start as drafts.
- Set `draft: false` when the owner wants content included in the next publication.
- Blog navigation appears only when at least one visible post exists.
- Shared contact details: `hugo.yaml`. Layout: `layouts/`. Design: `assets/css/site.css`.
- Keep links compatible with both a custom domain and a GitHub Pages repository path.
- Never edit generated `public/` or `resources/`. Do not commit `.tools/`.
- Hugo upgrades require updating `.hugo-version` and `scripts/hugo-checksums.txt` together.

## Publishing

Changes stay local until committed and pushed. Pushes to `main` trigger the Pages
workflow. Pull requests build without deploying. Build before publishing. Treat
requests to edit or preview as local work; commit/push when the owner asks to
publish. Preserve existing uncommitted work. Explain the published changes in plain language.
