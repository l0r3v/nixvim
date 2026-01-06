{...}: {
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
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
    treesitter-context = {
      enable = true;
      settings = {
        line_numbers = true;
        max_lines = 0;
        min_window_height = 0;
        mode = "topline";
        multiline_threshold = 20;
        separator = "-";
        trim_scope = "inner";
        zindex = 20;
      };
    };
  };
}
