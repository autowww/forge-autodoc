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

## Using fa as a submodule in another repo

Add **forge-autodoc** as a submodule at `forge-autodoc/`, then initialize nested Kitchensink:

```bash
git submodule update --init --recursive forge-autodoc
```

Put **source** Markdown in a directory you choose (e.g. `fa-tutorial-md/`). Send **generated** HTML to **`tutorials/`** at the host repo root:

```bash
# From the host repository root (PYTHONPATH must include the fa submodule tree)
PYTHONPATH=forge-autodoc python3 -m forge_autodoc build \
  --content ./fa-tutorial-md \
  --out ./tutorials \
  --kitchensink ./KITCHENSINK_ROOT \
  --handbook-name "Project tutorials"
```

**Kitchensink path (`--kitchensink`):** Prefer the host’s own `kitchensink/` submodule when it exists so themes match the rest of the project. Otherwise use `forge-autodoc/kitchensink/` (requires recursive submodule init).

Or use a YAML config at the host root; paths in the file are relative to **the YAML file’s directory** (see [`examples/fa-handbook.host.example.yaml`](examples/fa-handbook.host.example.yaml)).

Copy [`examples/build-fa-tutorials.host.example.sh`](examples/build-fa-tutorials.host.example.sh) to the host as `build-fa-tutorials.sh` and adjust names. Add `tutorials/` to the host `.gitignore` if you do not commit built HTML (remove any legacy `fa-tutorials/` entry after migrating).

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
