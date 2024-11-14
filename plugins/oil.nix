_: {
  #OIL
  opts = {
    enable = true;
    settings = {
      columns = [
        "icon"
      ];
      keymaps = {
        "<C-c>" = false;
        "<C-l>" = false;
        "<C-r>" = "actions.refresh";
        "<leader>qq" = "actions.close";
        "y." = "actions.copy_entry_path";
        "g?" = "actions.show_help";
        "<CR>" = "actions.select";
        "-" = "actions.parent";
        "gs" = "actions.change_sort";
        "gx" = "actions.open_external";
        "g." = "actions.toggle_hidden";
        "g\\" = "actions.toggle_trash";
      };
      skip_confirm_for_simple_edits = true;
      view_options = {
        show_hidden = true;
      };
      win_options = {
        concealcursor = "ncv";
        conceallevel = 3;
        cursorcolumn = false;
        foldcolumn = "0";
        list = false;
        signcolumn = "no";
        spell = false;
        wrap = false;
      };
    };
  };
}
