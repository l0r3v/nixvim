# Nixvim Configuration

This is my personal configuration for [Nixvim](https://github.com/nixvim/nixvim), a Neovim configuration built using Nix.

## Installation

As it is a standalone module, you can try it using:

```bash
    nix run github:l0r3v/nixvim
```

To install it, you can add it to your flake inputs:

```nix
    nixvim = {
      url = "github:l0r3v/nixvim";
    };
```

There are two different packages in the flake, "default" (or "bare") and "full". The only difference is in the luasnip, vimtex and cmp plugins.
Basically I am using the "bare" package for my homelab and full for everything else. I have no need for my homelab to have the tex plugins. The default is "bare", so to access the "full" package you have to write:

```bash
    nix run github:l0r3v/nixvim#full
```

#### Bonus

My Nixvim configuration does not come with a pre-installed theme. This is because I manage everything with Stylix, which supports Nixvim.
In my `home.nix` I have:

```nix
{config, pkgs, inputs, ...}:
let
    nixvim-package = inputs.nixvim.packages.${system}.default;
    themed-nixvim = nixvim-package.extend config.lib.stylix.nixvim.config;
    in {...}
```

And the theme specified in my Stylix configuration is applied directly!

Note: If you want to install the full package you just have to substitute "default" with "full" like this:

```nix
    nixvim-package = inputs.nixvim.packages.${system}.full;
```
