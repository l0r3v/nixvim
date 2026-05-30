{pkgs, ...}: {
  plugins = {
    dap = {
      enable = true;
    };
  };
  extraPackages = with pkgs; [
    netcoredbg
  ];
  extraConfigLua = ''
        local dap = require("dap")
    dap.adapters.godot = {
    	type = "server",
    	host = "127.0.0.1",
    	port = 6006,
    }

    dap.configurations.gdscript = {
    	{
    		type = "godot",
    		request = "launch",
    		name = "Launch scene",
    		project = "''${workspaceFolder}",
    		launch_scene = true,
    	},
    }

    dap.adapters.coreclr = {
    	type = "executable",
    	command = "${pkgs.netcoredbg}/bin/netcoredbg",
    	args = {"--interpreter=vscode"},
    }

    dap.configurations.cs = {
    	{
    		type = "coreclr",
    		name = "launch - netcoredbg",
    		request = "launch",
    		program = function()
    			return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    		end,
    	},
    }

    local map = vim.keymap.set
    local dopts = { noremap = true, silent = true }
    map("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", vim.tbl_extend("force", dopts, { desc = "DAP: Continue" }))
    map("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", vim.tbl_extend("force", dopts, { desc = "DAP: Toggle breakpoint" }))
    map("n", "<leader>dB", "<cmd>lua require('dap').set_breakpoint(vim.fn.input('Condition: '))<CR>", vim.tbl_extend("force", dopts, { desc = "DAP: Conditional breakpoint" }))
    map("n", "<leader>di", "<cmd>lua require('dap').step_into()<CR>", vim.tbl_extend("force", dopts, { desc = "DAP: Step into" }))
    map("n", "<leader>do", "<cmd>lua require('dap').step_over()<CR>", vim.tbl_extend("force", dopts, { desc = "DAP: Step over" }))
    map("n", "<leader>dO", "<cmd>lua require('dap').step_out()<CR>", vim.tbl_extend("force", dopts, { desc = "DAP: Step out" }))
    map("n", "<leader>dr", "<cmd>lua require('dap').restart()<CR>", vim.tbl_extend("force", dopts, { desc = "DAP: Restart" }))
    map("n", "<leader>dq", "<cmd>lua require('dap').terminate()<CR>", vim.tbl_extend("force", dopts, { desc = "DAP: Terminate" }))
  '';
}
