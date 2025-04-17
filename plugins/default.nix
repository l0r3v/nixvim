{pkgs, ...}: {
  imports = [
    ./autoclose.nix
    ./cmp.nix
    ./helpview.nix
    ./image.nix
    ./lsp.nix
    ./lualine.nix
    ./luasnip/luasnip.nix
    ./neorg.nix
    ./oil.nix
    ./render-markdown.nix
    ./telekasten.nix
    ./telescope.nix
    ./treesitter-context.nix
    ./treesitter-refactor.nix
    ./treesitter.nix
    ./vimtex.nix
    ./web-devicons.nix
    ./nvim-ufo.nix
  ];
}
