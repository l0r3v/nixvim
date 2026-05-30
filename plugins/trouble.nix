_: {
  plugins.trouble = {
    enable = true;
    settings = {
      auto_close = true;
      auto_jump = true;
      auto_preview = true;
      focus = true;
      follow = true;
    };
  };
  extraConfigLua = ''
    vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Toggle Trouble diagnostics", noremap = true, silent = true })
  '';
}
