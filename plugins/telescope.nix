_: {
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native = {
        enable = true;
        settings = {
          case = "smart";
        };
      };
    };
    settings = {
      defaults = {
        path_display = ["truncate"];
        layout_config = {
          horizontal = {
            prompt_position = "top";
          };
        };
        sorting_strategy = "ascending";
      };
    };
  };
}
