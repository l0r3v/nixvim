{
  config,
  pkgs,
  lib,
  mode ? "bare",
  ...
}: {
  options.mode = lib.mkOption {
    type = lib.types.enum ["full" "bare"];
    default = "bare";
    description = "Versions (full/bare)";
  };
  imports =
    [
      ./config
      ./plugins
    ]
    ++ lib.optionals (mode == "full") [
      ./plugins/full.nix
    ];
  config = {
    viAlias = true;
    vimAlias = true;
  };
}
