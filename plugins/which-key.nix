{...}: {
  plugins.which-key = {
    enable = true;
    settings = {
      icons = {
        breadcrumb = "»";
        group = "+";
        separator = ""; # ➜
      };
      win = {
        border = "none";
        wo.winblend = 0;
      };
    };
  };
}
