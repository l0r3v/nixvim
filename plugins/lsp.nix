{
  pkgs,
  lib,
  ...
}: let
  inherit (lib) getExe;
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  plugins = {
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
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
          settings = let
            flake = ''(builtins.getFlake "/home/lorev/nixos/XPSnixos")'';
          in {
            nixpkgs = {
              expr = "import ${flake}.inputs.nixpkgs { }";
            };
            formatting = {
              command = ["${getExe pkgs.alejandra}"];
            };
            options = {
              nixvim.expr = ''${flake}.inputs.nixvim.packages.${system}.default.options'';
              home-manager.expr = ''${flake}.nixosConfigurations.XPSnixos.options.home-manager.users.type.getSubOptions []'';
              nixos.expr = ''${flake}.nixosConfigurations.XPSnixos.options'';
            };
          };
        };
      };
    };
  };
  # extraConfigLua = ''
  #   require("lspconfig")["gdscript"].setup({
  #   	name = "godot",
  #   	cmd = vim.lsp.rpc.connect("127.0.0.1", "6005"),
  #   })
  # '';
}
