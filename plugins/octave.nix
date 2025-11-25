{pkgs, ...}: {
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "vim-octave";
      src = pkgs.fetchFromGitHub {
        owner = "gnu-octave";
        repo = "vim-octave";
        rev = "61268df";
        hash = "sha256-+ru34zasfJCJOS0z38RnqE2wMGeLfw2GIB/guy1RmAU=";
      };
    })
  ];
}
