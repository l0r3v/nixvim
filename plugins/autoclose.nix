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
    options = {
      auto_indent = true;
    };
  };
}
