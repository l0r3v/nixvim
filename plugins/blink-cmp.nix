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

        #  Completamento
        completion = {
          accept.auto_brackets.enabled = true;
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

        # Firma e snippet
        signature.enabled = true;
        snippets.preset = mkIf config.plugins.luasnip.enable "luasnip";

        #  Sorgenti di completamento
        sources = {
          min_keyword_length = 1;
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };
      };
    };

    #  Compatibilità con altri plugin (es. lsp)
    blink-compat.enable = true;
    lsp.capabilities = ''
      capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
    '';
  };
}
