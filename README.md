# Nixvim Configuration

This is my personal configuration for [Nixvim](https://github.com/nixvim/nixvim), a Neovim configuration built using Nix.

## Features

- Modular and easily extendable configuration.
- Configuration management with Nix for a declarative approach.

## Installation

As it is a standalone module, you can try it using:

```bash
    nix run github:Iorev/nixvim-config
```

To install it, you can add it to your flake inputs:

```nix
    nixvim = {
      url = "github:Iorev/nixvim-config";
      inputs.nixpkgs.follows = "nixpkgs";
    };
```

#### Bonus
The Nixvim configuration does not come with a pre-installed theme. This is because I manage everything with Stylix, which supports Nixvim.
In my `home.nix` I have:

```nix
{config, pkgs, inputs, ...}:
let
    nixvim-package = inputs.nixvim.packages.${system}.default;
    themed-nixvim = nixvim-package.extend config.lib.stylix.nixvim.config;
    in {...}
```

And the theme specified in my Stylix configuration is applied directly!

### Installed packages 

- **luasnip**
- **autoclose**
- **cmp**
- **dap**
- **helpview**
- **image**
- **lsp**
- **lualine**
- **neorg**
- **oil**
- **render-markdown**
- **telekasten**
- **telescope**
- **treesitter-context**
- **treesitter-refactor**
- **treesitter**
- **vimtex**
- **web-devicons**

## Contributing

If you want to contribute to this configuration, feel free to fork it and submit a pull request. Any improvements or suggestions are welcome!
