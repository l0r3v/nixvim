{
  description = "lorev's NixVim config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nix formatting pack
    # https://gerschtli.github.io/nix-formatter-pack/nix-formatter-pack-options.html
    nix-formatter-pack = {
      url = "github:Gerschtli/nix-formatter-pack";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixvim,
    nix-formatter-pack,
    ...
  }: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in {
    formatter = forAllSystems (
      system:
        nix-formatter-pack.lib.mkFormatter {
          pkgs = nixpkgs.legacyPackages.${system};

          config.tools = {
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
            statix.enable = true;
          };
        }
    );

    packages = forAllSystems (
      system: {
        default = nixvim.legacyPackages.${system}.makeNixvimWithModule {
          module = {
            pkgs,
            lib,
            config,
            ...
          }: {
            imports = [
              (import ./. {
                inherit pkgs lib config;
                mode = "bare";
              })
            ];
          };
        };
        full = nixvim.legacyPackages.${system}.makeNixvimWithModule {
          module = {
            pkgs,
            lib,
            config,
            ...
          }: {
            imports = [
              (import ./. {
                inherit pkgs lib config;
                mode = "bare";
              })
            ];
          };
        };
      }
    );
  };
}
