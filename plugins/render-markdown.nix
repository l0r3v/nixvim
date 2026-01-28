{ pkgs, ... }: {
  extraPackages = [
    pkgs.python3Packages.pylatexenc
  ];
  plugins.render-markdown = {
    enable = true;
    settings = {
      win_options = {
        concealcursor = {
          default = {
            __raw = "vim.api.nvim_get_option_value('concealcursor', {})";
          };
          rendered = "";
        };
        conceallevel = {
          default = {
            __raw = "vim.api.nvim_get_option_value('conceallevel', {})";
          };
          rendered = 3;
        };
      };
      enabled = true;
      bullet = {
        icons = [
          "󰫢 "
        ];
        right_pad = 1;
      };
      code = {
        above = " ";
        below = " ";
        border = "thick";
        language_pad = 2;
        left_pad = 2;
        position = "right";
        right_pad = 2;
        sign = false;
        width = "block";
      };
      heading = {
        border = true;
        icons = [
          "1 "
          "2 "
          "3 "
          "4 "
          "5 "
          "6 "
        ];
        position = "inline";
        sign = false;
        width = "full";
      };
      latex = {
        enabled = true;
        position = "center";
      };
      render_modes = true;
    };
  };
}
