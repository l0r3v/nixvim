{pkgs, ...}: {
  extraPackages = with pkgs; [
    alejandra # Nix
    stylua # Lua
    clang-tools # C/C++
    rustfmt # Rust
    nodePackages.prettier # JS / TS / JSON / Markdown / YAML
    black # Python
  ];
  plugins.conform-nvim = {
    enable = true;
    settings = {
      formatters_by_ft = {
        nix = ["alejandra"];
        lua = ["stylua"];
        c = ["clang-format"];
        cpp = ["clang-format"];
        rust = ["rustfmt"];
        javascript = ["prettier"];
        typescript = ["prettier"];
        json = ["prettier"];
        yaml = ["prettier"];
        markdown = ["prettier"];
        python = ["black"];
      };

      format_on_save = {
        timeout_ms = 500;
        lsp_fallback = true;
      };
    };
  };
}
