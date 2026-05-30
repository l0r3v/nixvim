{
  lib,
  mode ? "bare",
  ...
}: {
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
