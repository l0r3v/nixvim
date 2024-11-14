_: {
  #LSP
  opts = {
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
        settings = {
          nixpkgs = {
            expr = ''
              import <nixpkgs> {}
              import (builtins.getFlake \"/home/lorev/nixos-config\").inputs.nixpkgs { }
            '';
          };
          formatting = {
            command = ["alejandra"];
          };
          options = {
            nixvim = {
              expr = ''(builtins.getFlake "/home/lorev/nixos-config").packages.x86_64-linux.neovimNixvim.options'';
            };
            nixos = {
              expr = ''(builtins.getFlake "/home/lorev/nixos-config").nixosConfigurations.XPSnixos.options'';
            };
            home_manager = {
              expr = ''(builtins.getFlake "/home/lorev/nixos-config").homeConfigurations.lorev.options'';
            };
          };
        };
      };
    };
  };
}
