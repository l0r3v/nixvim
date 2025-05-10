{...}: {
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
  plugins.treesitter-context = {
    enable = true;
    settings = {
      line_numbers = true;
      max_lines = 0;
      min_window_height = 0;
      mode = "cursor";
      multiline_threshold = 0;
      separator = "-";
      trim_scope = "inner";
      zindex = 10;
    };
  };
  plugins.treesitter-refactor = {
    enable = true;
    highlightDefinitions = {
      enable = true;
      # Set to false if you have an `updatetime` of ~100.
      clearOnCursorMove = false;
    };
  };
}
