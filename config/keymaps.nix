{
  globals.mapleader = " ";
  keymaps = [
    {
      key = "ò";
      action = ":";
    }
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
    }
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
    }
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
    }
    {
      action = "<cmd>Telescope live_grep<CR>";
      key = "<leader>g";
    }
  ]; #end of remap
  extraConfigVim = ''
     let maplocalleader = ","
    "imap <silent><expr> <C-K> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<C-K>'
    "smap <silent><expr> <C-K> luasn#jumpable(1) ? '<Plug>luasnip-jump-next' : '<C-K>'
    "imap <silent><expr> <C-L> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-L>'
    "smap <silent><expr> <C-L> luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<C-L>'
     nmap <leader>c <Plug>(vimtex-compile)
     nmap <leader>ii <Plug>(vimtex-toc-toggle)
     inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
     nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
  '';
  extraConfigLua = ''
          local tlsc = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', tlsc.find_files, {})
            vim.keymap.set('n', '<leader>fb', tlsc.buffers, {})
            vim.keymap.set('n', '<C-p>', tlsc.git_files, {})

            vim.keymap.set('n', '<leader>fs', function()
              tlsc.grep_string({ search = vim.fn.input("Grep > ")})
            end)
          -- Launch panel if nothing is typed after <leader>z
    vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
  '';
}
