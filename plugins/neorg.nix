{pkgs, ...}: {
  plugins.neorg = {
    enable = true;
    settings.load = {
      "core.defaults" = {__empty = null;};
      "core.summary" = {__empty = null;};
      #"core.completion" = {engine = "[nvim-cmp]";};
      "core.concealer" = {__empty = null;};
      "core.latex.renderer" = {__empty = null;};
      "core.dirman" = {
        config = {
          workspaces = {
            notes = "~/notes/";
            current_course = "~/current_course/neorg_notes/";
          };
          default_workspace = "current_course";
        };
      };
    };
  };
}
