-- ~/.config/nvim/lua/plugins/terminal.lua

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      direction = "float", -- Make the terminal a floating window
      close_on_exit = false, -- Close the terminal window when the process exits
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
      },
    },
  },
}
