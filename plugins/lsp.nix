{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
in {
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        gdscript = {
          enable = true;
          package = null;
        };
        omnisharp = {
          enable = true;
          settings = {
            enableRoslynAnalyzers = true;
            enableEditorConfigSupport = true;
            enableImportCompletion = true;
          };
        };
        ts_ls.enable = true;
        lua_ls.enable = true;
        texlab.enable = true;
        clangd.enable = true;
        matlab_ls.enable = true;
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };

        nixd = {
          enable = true;
          settings = {
            formatting = {
              command = ["${getExe pkgs.alejandra}"];
            };
          };
        };
      };
    };
  };
}
