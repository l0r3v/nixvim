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
  '';
}
