{pkgs, ...}: let
  tex = pkgs.texlive.combine {
    inherit
      (pkgs.texlive)
      scheme-small
      collection-langitalian
      latexmk
      titlesec
      titling
      pgfplots
      wrapfig
      import
      cancel
      xifthen
      transparent
      cleveref
      ifmtarg
      l3packages
      tcolorbox
      adjustbox
      physics
      tikzfill
      pdfcol
      listingsutf8
      ;
  };
in {
  plugins.vimtex = {
    enable = true;
    texlivePackage = tex;
    settings = {
      view_method = "zathura";
      quickfix_mode = 0;
    };
  };
}
