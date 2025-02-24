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
  '';
  extraConfigLua = ''
          local tlsc = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', tlsc.find_files, {})
            vim.keymap.set('n', '<leader>fb', tlsc.buffers, {})
            vim.keymap.set('n', '<C-p>', tlsc.git_files, {})

            vim.keymap.set('n', '<leader>ps', function()
              tlsc.grep_string({ search = vim.fn.input("Grep > ")})
            end)
          -- Launch panel if nothing is typed after <leader>z
    vim.keymap.set("n", "<leader>z", "<cmd>Telekasten panel<CR>")

    -- Most used functions
    vim.keymap.set("n", "<leader>zf", "<cmd>Telekasten find_notes<CR>")
    vim.keymap.set("n", "<leader>zg", "<cmd>Telekasten search_notes<CR>")
    vim.keymap.set("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>")
    vim.keymap.set("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>")
    vim.keymap.set("n", "<leader>zn", "<cmd>Telekasten new_note<CR>")
    vim.keymap.set("n", "<leader>zc", "<cmd>Telekasten show_calendar<CR>")
    vim.keymap.set("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>")
    vim.keymap.set("n", "<leader>zI", "<cmd>Telekasten insert_img_link<CR>")
    vim.keymap.set("n", "<leader>zx", "<cmd>Telekasten toggle_todo<CR>")

    -- Call insert link automatically when we start typing a link
    vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")
    vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
  '';
}
