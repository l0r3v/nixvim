{pkgs, self, lib, ...}: {
  plugins = {
    lsp = {
      enable = true;
      servers = {
        ts_ls.enable = true;
        lua_ls.enable = true;
        texlab.enable = true;
        clangd.enable = true;
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };

        nixd = {
          enable = true;
          settings = 
            let 
              flake = '' (builtins.getFlake "/home/lorev/nixos-config/")'';
            in
            {
            nixpkgs = {
              expr = "import ${flake}.inputs.nixpkgs { }";
            };
            formatting = {
              command = ["${lib.getExe pkgs.alejandra}"];
            };
            options = {
              nixvim = {
                expr = ''${flake}.inputs.nixvim.packages.x86_64-linux.default.options'';
              };
              nixos = {
                expr = ''${flake}.nixosConfigurations.XPSnixos.options'';
              };
              home_manager = {
                expr = ''${flake}.homeConfigurations.lorev.options'';
              };
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
