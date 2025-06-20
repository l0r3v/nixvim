{
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
in {
  plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        appearance = {
          nerd_font_variant = "mono";
          use_nvim_cmp_as_default = false;
        };
        completion = {
          accept = {
            auto_brackets = {
              enabled = true;
            };
          };
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
            window.border = "rounded";
          };
          ghost_text.enabled = true;
        };
        keymap = {
          preset = "super-tab";
        };
        signature = {
          enabled = true;
        };
        snippets.preset = mkIf config.plugins.luasnip.enable "luasnip";
        sources.default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
        ];
      };
    };
    blink-compat.enable = true;
    lsp.capabilities = ''
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
    '';
  };
}
