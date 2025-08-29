-- ~/.config/nvim/lua/plugins/java-support.lua

return {
	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
		},
	},
}
