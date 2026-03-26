#!/usr/bin/env bash
# Copy to your host repo root as build-fa-tutorials.sh, chmod +x, then edit fa-handbook.yaml.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

FA="$ROOT/forge-autodoc"
if [[ ! -f "$FA/forge_autodoc/__init__.py" ]]; then
  echo "[build-fa-tutorials] Missing forge-autodoc. Run:" >&2
  echo "  git submodule update --init --recursive forge-autodoc" >&2
  exit 1
fi

CONFIG="$ROOT/fa-handbook.yaml"
if [[ ! -f "$CONFIG" ]]; then
  echo "[build-fa-tutorials] Missing $CONFIG (copy from forge-autodoc/examples/fa-handbook.host.example.yaml)" >&2
  exit 1
fi

PYTHONPATH="$FA" python3 -m forge_autodoc build --config "$CONFIG" "$@"
