{pkgs, ...}: {
  ## This two plugins installation are stolen from
  ## https://github.com/JMartJonesy/kickstart.nixvim/blob/standalone/config/plugins/nvim-cmp.nix
  plugins.cmp-nvim-lsp = {
    enable = true;
  };

  # https://nix-community.github.io/nixvim/plugins/cmp-path.html
  plugins.cmp-path = {
    enable = true;
  };
  plugins.cmp = {
    enable = true;
    settings = {
      completion = {
        completeopt = "menu,menuone,noinsert";
      };
      autoEnableSources = true;
      experimental = {ghost_text = true;};
      performance = {
        debounce = 60;
        fetchingTimeout = 500;
        maxViewEntries = 20;
      };
      snippet = {
        expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
      };
      formatting = {fields = ["kind" "abbr" "menu"];};
      sources = [
        {
          name = "nvim_lsp";
          keywordLength = 3;
        }
        #{name = "neorg";}
        #{
        #  name = "buffer"; # text within current buffer
        #  #option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
        #  keywordLength = 5;
        #}
        {
          name = "path"; # file system paths
          keywordLength = 3;
        }
        {
          name = "luasnip"; # snippets
          keywordLength = 4;
        }
      ];

      window = {
        completion = {border = "solid";};
        documentation = {border = "solid";};
      };

      #mapping = {
      #  "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      #  "<C-j>" = "cmp.mapping.select_next_item()";
      #  "<C-k>" = "cmp.mapping.select_prev_item()";
      #  "<C-e>" = "cmp.mapping.abort()";
      #  "<C-b>" = "cmp.mapping.scroll_docs(-4)";
      #  "<C-f>" = "cmp.mapping.scroll_docs(4)";
      #  "<C-Space>" = "cmp.mapping.complete()";
      #  "<CR>" = "cmp.mapping.confirm({ select = true })";
      #  "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
      #};
      mapping = {
        "<C-j>" = "cmp.mapping.select_next_item()";
        "<C-k>" = "cmp.mapping.select_prev_item()";
        "<C-e>" = "cmp.mapping.abort()";
        "<C-v>" = "cmp.mapping.scroll_docs(-4)";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<C-Space>" = "cmp.mapping.complete()";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
        "<Tab>" = ''
          cmp.mapping(function(fallback)
            if require("luasnip").expand_or_locally_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' })
        '';
        "<S-Tab>" = ''
          cmp.mapping(function(fallback)
            if require("luasnip").locally_jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' })
        '';
      };
    };
  };
}
