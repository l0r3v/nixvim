{
  config,
  lib,
  ...
}: {
  imports = [
    ./config
    ./plugins
  ];
  viAlias = true;
  vimAlias = true;
}
