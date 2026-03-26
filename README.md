# forge-autodoc (**fa**)

Build **static technical handbooks / tutorials** for engineers from your repository’s Markdown, using **[forgesdlc-kitchensink](https://github.com/autowww/forgesdlc-kitchensink)** for `handbook_page`, prose styling, diagrams, and shared assets.

## Layout

- `forge_autodoc/` — Python package (Markdown → HTML, sidebars, page assembly).
- `kitchensink/` — git submodule (Forge design system). Bump with `git submodule update --remote kitchensink` when you need newer KS.

## Install

From this repo root:

```bash
pip install -e .
# or: pip install markdown PyYAML && PYTHONPATH=. python3 -m forge_autodoc --help
```

## Quick CLI

Build a single content tree to a directory (flat HTML filenames derived from paths):

```bash
python3 -m forge_autodoc build \
  --kitchensink ./kitchensink \
  --content ./path/to/docs \
  --out ./dist/handbook \
  --handbook-name "My handbook"
```

Or use a YAML config file:

```bash
python3 -m forge_autodoc build --config handbook.yaml
```

See [`examples/handbook.example.yaml`](examples/handbook.example.yaml).

## Library usage

Host projects (e.g. **blueprints-website**) add **forge-autodoc** as a submodule and pass their own `kitchensink` path so the handbook uses the same KS revision as the site:

```python
from pathlib import Path
import forge_autodoc as fa

ks = Path("kitchensink")
body = fa.markdown_to_handbook_html("# Title\n\nHello.")
html = fa.assemble_handbook_page(
    kitchensink_root=ks,
    browser_title="Page",
    handbook_name="Docs",
    ...
)
```

## Requirements

- Python 3.10+
- `pip install markdown PyYAML`
- Kitchensink checkout (submodule here or elsewhere)
