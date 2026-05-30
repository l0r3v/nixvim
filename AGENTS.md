# Agent Instructions

## Build & Test Commands

```bash
nix flake check          # Validate all flake outputs (run this first)
nix build .#default      # Build bare mode
nix build .#full         # Build full mode
nix fmt .                # Format Nix files (alejandra + deadnix + statix)
nix run .#default -- --headless '+qa'  # Smoke test bare
nix run .#full -- --headless '+qa'     # Smoke test full
```

## Two Modes: bare vs full

- **bare** (default): Core plugins only — loaded via `plugins/default.nix`
- **full**: Adds heavy tooling — also loads `plugins/full.nix`

When adding a plugin, decide which mode it belongs to:
- Lightweight/essential (LSP, telescope, treesitter) → `plugins/default.nix`
- Heavy/optional (completion, snippets, DAP, formatters) → `plugins/full.nix`

## Auto-Import Behavior

- `config/default.nix` auto-imports all `.nix` files in `config/`
- `plugins/default.nix` and `plugins/full.nix` explicitly list imports

New plugin files must be added to the appropriate imports list.

## Lua in Nix Strings

Escape `${...}` to prevent Nix interpolation:
```nix
# Wrong - Nix tries to interpolate workspaceFolder
extraConfigLua = ''
  project = "${workspaceFolder}"
'';

# Correct - double single-quote escapes the dollar
extraConfigLua = ''
  project = "''${workspaceFolder}"
'';
```

## No Theme

Theme is managed externally via Stylix. Do not add colorschemes or theme plugins.
