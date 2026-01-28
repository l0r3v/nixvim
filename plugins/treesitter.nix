{ pkgs, ... }: {
  plugins = {
    treesitter = {
      enable = true;
      nixvimInjections = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        markdown
        markdown_inline
        latex
        lua
        vim
        vimdoc
        query
        python
        rust
        nix
        bash
        c
        cpp
      ];
      settings = {
        highlight = {
          enable = true;
          disable = {
            __raw = ''
              function(lang, buf)
                if lang == "latex" then
                  local ok, ft = pcall(vim.api.nvim_get_option_value, "filetype", { buf = buf })
                  if ok and ft == "tex" then
                    return true
                  end
                end
                return false
              end
            '';
          };
        };
        indent.enable = true;
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
