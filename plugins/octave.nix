{pkgs,...}:{
extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
    name = "vim-octave";
    src = pkgs.fetchFromGitHub {
        owner = "gnu-octave";
        repo = "vim-octave";
        rev = "61268df";
        hash = "sha256-HfcmlQPMwef4fnBMV4rgt/tASlfTXJr82uG1fcNSINw=";
    };
})];
}
