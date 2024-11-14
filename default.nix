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
  viAlias = true;
  vimAlias = true;
  defaultEditor = true;
}
