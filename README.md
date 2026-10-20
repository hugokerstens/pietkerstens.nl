# Piet Kerstens

Piet Kerstens' portfolio website. This repository is the source of truth for the
website's content, design, and publishing workflow.

The gallery displays artworks in four desktop columns and a single mobile column.
Click an artwork to enlarge it; use the arrows to browse and Escape to close.
Individual artwork pages also work without JavaScript.

## Start on Windows

First-time setup, with help from the person handing over the site:

1. Install Git for Windows and the Windows app that provides Codex. Sign in to Codex.
2. Clone this repository to a local folder and open that folder as a Codex project.
   GitHub Desktop is an optional graphical way to clone and sign in to GitHub.
3. Double-click **Preview website.cmd**. The first run downloads the site builder
   from its official GitHub release and verifies its checksum. No administrator
   rights or global installation are needed. Internet access is needed for this download.
4. Your browser opens **http://localhost:1313/** when the preview is ready.
   Leave the preview window open while editing. Press Ctrl+C to stop it.

After setup, just open the project in Codex and start the preview. No commands or
code knowledge are needed for ordinary editing. The launcher uses a process-only
PowerShell execution policy; it does not change the computer's saved policy.
Managed laptop policies may require help from the laptop administrator.

Example requests to Codex:

- “Voeg deze afbeelding toe als schilderij, met de titel … en afmetingen …”
- “Zet dit schilderij als eerste in de galerij.”
- “Maak een conceptblog over mijn nieuwe werk.”
- “Maak de ruimte tussen de schilderijen iets groter.”
- “Controleer de website en publiceer mijn wijzigingen.”

Edits appear automatically in the preview. Drafts are visible locally, but are
excluded from the published site. Publication happens after commit and push to
`main`, so experimenting locally does not change the live website.

If the preview fails, paste the error into Codex. Port 1313 must be free; stop an
existing preview before opening another. The initial GitHub sign-in and repository
access should be tested during handover, along with one edit, preview, and publish.

## Content and design

| Location | Purpose |
| --- | --- |
| `content/artworks/<name>/` | One artwork's `index.md` and original image |
| `content/posts/<name>/` | A blog post's `index.md` and optional images |
| `hugo.yaml` | Contact details, site title, and shared settings |
| `layouts/` | Page templates |
| `assets/css/site.css` | Design and responsive layout |
| `assets/js/gallery.js` | Accessible image viewer |
| `archetypes/` | Templates for new artwork and posts |
| `AGENTS.md` | Instructions Codex reads when working here |

Artwork fields include `title`, `weight` (lower comes first), `material`,
`dimensions`, `image`, and `alt`. Keep the image next to `index.md` and use its
filename in `image`. The build creates smaller WebP thumbnails.
Each artwork's `index.md` defines its title, material, dimensions, and image description.

There are no placeholder published blog posts. Add the first real post to make
the Blog navigation appear. Markdown images such as `![Beschrijving](photo.jpg)`
work with images in the post folder.

## Publish to GitHub Pages

One-time repository setup:

1. In **Settings → Pages → Build and deployment → Source**, select **GitHub Actions**.
2. Push the project to `main`. The workflow builds with the pinned site builder version,
   uploads `public/`, and deploys it to Pages. Pull requests only build.
3. Use the Pages address shown by GitHub. The workflow automatically
   uses the configured Pages URL, including a repository subpath.
4. To use the website's domain, configure `pietkerstens.nl` under Pages
   **Custom domain**, set its DNS for GitHub Pages, and enable HTTPS.
   Keep any existing mail DNS records. The next deployment uses the custom URL.

DNS is managed separately from the repository. Build output is not committed.
To undo a published change, ask Codex to revert
that change and publish the revert. Account access, Pages settings, DNS, and the
first real deployment must be verified in GitHub during handover.

## Developer commands

Hugo **0.168.0** is pinned in `.hugo-version`; standard Hugo is sufficient.

```sh
# Linux: helper downloads the matching verified binary on first use
# macOS: install the pinned Hugo version first, then use these same commands
bash scripts/hugo.sh server --buildDrafts --bind 127.0.0.1 --baseURL http://localhost:1313/
bash scripts/hugo.sh --gc --minify
bash scripts/hugo.sh new content artworks/nieuw-werk --kind artworks
bash scripts/hugo.sh new content posts/nieuw-bericht --kind posts
```

```powershell
# Windows: run these in PowerShell, or ask Codex to run them
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/hugo.ps1 --gc --minify
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/hugo.ps1 new content artworks/nieuw-werk --kind artworks
powershell.exe -NoProfile -ExecutionPolicy Bypass -File scripts/hugo.ps1 new content posts/nieuw-bericht --kind posts
```

For a preview button in Codex, configure a project action to run the Windows
preview command from `AGENTS.md` (or the shell preview command on Linux/macOS).
No Codex configuration file is required to run the website.

## Assets and licenses

Artwork images and the logo are website assets and are not offered under an
open-source license.
Raleway and Cormorant Garamond are bundled locally with their SIL Open Font
License files under `static/fonts/`. No third-party scripts or font requests are
needed when viewing the site.
