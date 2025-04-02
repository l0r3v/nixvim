{pkgs, ...}: {
  plugins.autoclose = {
    enable = true;
    settings.keys = {
      "`" = {
        escape = false;
        close = false;
        pair = "``";
      };
      "'" = {
        escape = false;
        close = false;
        pair = "''";
      };
    };
    settings.options = {
      auto_indent = true;
      disabled_filetypes = [
        "tex"
        "text"
      ];
      disable_command_mode = true;
    };
  };
}
