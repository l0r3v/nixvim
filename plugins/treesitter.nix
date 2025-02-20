{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;
    nixvimInjections = true;
    languageRegister = {
      markdown = [
        "telekasten"
      ];
    };
    settings = {
      highlight = {
        enable = true;
        disable = ["latex"];
      };
      indent.enable = true;
      auto_install = false;
      incremental_selection = {
        enable = true;
        keymaps = {
          init_selection = false;
          node_decremental = "grm";
          node_incremental = "grn";
          scope_incremental = "grc";
        };
      };
    };
  };
}
