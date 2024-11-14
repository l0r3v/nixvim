{

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
    {
    mode = "i";
    key = "<Tab>";
    action = "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'";
  }
  {
    mode = "s";
    key = "<Tab>";
    action = "luasnip#jumpable(1) ? '<Plug>luasnip-jump-next' : '<Tab>'";
  }
  {
    mode = "i";
    key = "<S-Tab>";
    action = "luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'";
  }
  {
    mode = "s";
    key = "<S-Tab>";
    action = "luasnip#jumpable(-1) ? '<Plug>luasnip-jump-prev' : '<S-Tab>'";
  }
  {
    mode = "n";
    key = "<leader>c";
    action = "<Plug>(vimtex-compile)";
  }
  {
    mode = "n";
    key = "<leader>ii";
    action = "<Plug>(vimtex-toc-toggle)";
  }
  {
    mode = "n";
    key = "<leader>pf";
    action = "<cmd>Telescope find_files<CR>";
  }
  {
    mode = "n";
    key = "<leader>fb";
    action = "<cmd>Telescope buffers<CR>";
  }
  {
    mode = "n";
    key = "<C-p>";
    action = "<cmd>Telescope git_files<CR>";
  }
  {
    mode = "n";
    key = "<leader>ps";
    action = "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ')})<CR>";
  }
  {
    mode = "n";
    key = "<leader>z";
    action = "<cmd>Telekasten panel<CR>";
  }
  {
    mode = "n";
    key = "<leader>zf";
    action = "<cmd>Telekasten find_notes<CR>";
  }
  {
    mode = "n";
    key = "<leader>zg";
    action = "<cmd>Telekasten search_notes<CR>";
  }
  {
    mode = "n";
    key = "<leader>zd";
    action = "<cmd>Telekasten goto_today<CR>";
  }
  {
    mode = "n";
    key = "<leader>zz";
    action = "<cmd>Telekasten follow_link<CR>";
  }
  {
    mode = "n";
    key = "<leader>zn";
    action = "<cmd>Telekasten new_note<CR>";
  }
  {
    mode = "n";
    key = "<leader>zc";
    action = "<cmd>Telekasten show_calendar<CR>";
  }
  {
    mode = "n";
    key = "<leader>zb";
    action = "<cmd>Telekasten show_backlinks<CR>";
  }
  {
    mode = "n";
    key = "<leader>zI";
    action = "<cmd>Telekasten insert_img_link<CR>";
  }
  {
    mode = "n";
    key = "<leader>zx";
    action = "<cmd>Telekasten toggle_todo<CR>";
  }
  {
    mode = "i";
    key = "[[";
    action = "<cmd>Telekasten insert_link<CR>";
  }
  {
    mode = "n";
    key = "-";
    action = "<CMD>Oil --float<CR>";
  }
];
}
