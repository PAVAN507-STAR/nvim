-- ~/.config/nvim/lua/plugins/snippets.lua
return {
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "tokyonight",
		},
	},
	{
		"L3MON4D3/LuaSnip",
		opts = function(_, opts)
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/custom/snippets" })
		end,
	},
}
