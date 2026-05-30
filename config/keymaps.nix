{
  globals.mapleader = " ";
  globals.maplocalleader = ",";

  keymaps = [
    # ----------------
    # 🧭 Navigazione & movimento
    # ----------------
    {
      mode = "n";
      key = "<C-u>";
      action = "<C-u>zz";
      options.desc = "Scroll up (centered)";
    }
    {
      mode = "n";
      key = "<C-d>";
      action = "<C-d>zz";
      options.desc = "Scroll down (centered)";
    }
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
      options.desc = "Next search result (centered)";
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
      options.desc = "Previous search result (centered)";
    }
    {
      mode = "n";
      key = "ò";
      action = ":";
      options.desc = "Italian-friendly command mode";
    }

    # ----------------
    # 🪶 Editing / movimento di blocchi
    # ----------------
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options.desc = "Move selection down";
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options.desc = "Move selection up";
    }

    # ----------------
    # 🔍 Telescope / ricerca
    # ----------------
    {
      mode = "n";
      key = "<leader>fw";
      action = "<cmd>Telescope grep_string<CR>";
      options.desc = "Find word under cursor";
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<CR>";
      options.desc = "List buffers";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
      options.desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>fs";
      action = "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ')})<CR>";
      options.desc = "Search for string";
    }
    {
      mode = "n";
      key = "<C-p>";
      action = "<cmd>Telescope git_files<CR>";
      options.desc = "Find git files";
    }

    # ----------------
    # 🧱 File management / Oil
    # ----------------
    {
      mode = "n";
      key = "-";
      action = "<CMD>Oil --float<CR>";
      options.desc = "Open parent directory (Oil)";
    }

    # ----------------
    # 🧰 Tools / vari
    # ----------------
    {
      mode = "n";
      key = "<leader>lg";
      action = "<cmd>LazyGit<CR>";
      options.desc = "Open LazyGit";
    }

    # ----------------
    # 🧾 LaTeX helpers
    # ----------------
    {
      mode = "n";
      key = "<leader>c";
      action = "<Plug>(vimtex-compile)";
      options.desc = "Compile LaTeX (vimtex)";
    }
    {
      mode = "n";
      key = "<leader>ii";
      action = "<Plug>(vimtex-toc-toggle)";
      options.desc = "Toggle TOC (vimtex)";
    }
  ];

  extraConfigLua = ''
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    -- =====================
    -- 🧭 Navigazione finestre
    -- =====================
    map("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
    map("n", "<C-j>", "<C-w>j", { desc = "Focus below window" })
    map("n", "<C-k>", "<C-w>k", { desc = "Focus above window" })
    map("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })
    map("n", "<leader>wv", ":vsplit<CR>", { desc = "Vertical split" })
    map("n", "<leader>ws", ":split<CR>", { desc = "Horizontal split" })
    map("n", "<leader>we", "<C-w>=", { desc = "Equalize splits" })
    map("n", "<leader>wq", ":close<CR>", { desc = "Close current window" })

    -- =====================
    -- 📄 Buffer management
    -- =====================
    map("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
    map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
    map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

    -- =====================
    -- 🧠 LSP mappings (buffer-local, only when LSP is attached)
    -- =====================
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bopts = { buffer = args.buf, noremap = true, silent = true }
        map("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", bopts, { desc = "Go to definition" }))
        map("n", "<leader>gD", vim.lsp.buf.declaration, vim.tbl_extend("force", bopts, { desc = "Go to declaration" }))
        map("n", "<leader>gi", vim.lsp.buf.implementation, vim.tbl_extend("force", bopts, { desc = "Go to implementation" }))
        map("n", "<leader>gr", vim.lsp.buf.references, vim.tbl_extend("force", bopts, { desc = "List references" }))
        map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", bopts, { desc = "Code action" }))
        map("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", bopts, { desc = "Rename symbol" }))
        map("n", "<leader>k", vim.lsp.buf.hover, vim.tbl_extend("force", bopts, { desc = "Hover documentation" }))
        map("n", "<leader>dl", vim.diagnostic.open_float, vim.tbl_extend("force", bopts, { desc = "Show diagnostic info" }))
        map("n", "<leader>dn", vim.diagnostic.goto_next, vim.tbl_extend("force", bopts, { desc = "Next diagnostic" }))
        map("n", "<leader>dp", vim.diagnostic.goto_prev, vim.tbl_extend("force", bopts, { desc = "Previous diagnostic" }))
      end,
    })

    -- =====================
    -- 🧩 Editing migliorato
    -- =====================
    map("n", "J", "mzJ`z", opts)                                -- Mantieni il cursore al centro dopo join
    map("x", "<leader>p", "\"_dP", { desc = "Paste without losing yank" }) -- Incolla senza perdere clipboard
    map("n", "Y", "yg$", { desc = "Yank until end of line" })

    -- =====================
    -- ⚙️ Varie
    -- =====================
    map("n", "<leader>qq", ":qall<CR>", { desc = "Quit all" })
  '';
}
