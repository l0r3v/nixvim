{
  config,
  lib,
  ...
}: {
  imports = [
    ./config
    ./plugins
  ];
  colorschemes.gruvbox.enable = true;
}
