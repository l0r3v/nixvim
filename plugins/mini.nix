{...}: {
  plugins.mini = {
    enable = true;
    modules = {
      ai = {
        n_lines = 50;
        search_method = "cover_or_next";
      };
      comment = {
        mappings = {
          comment = "<leader>/";
          comment_line = "<leader>/";
          comment_visual = "<leader>/";
          textobject = "<leader>/";
        };
      };
      diff = {
        view = {
          style = "sign";
        };
      };
      # starter = {
      #   evaluate_single = true;
      #   header = ''
      #     ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
      #     ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
      #     ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
      #     ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
      #     ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
      #   '';
      # };
      surround = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
    };
  };
}
