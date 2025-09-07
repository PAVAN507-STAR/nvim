-- ~/.config/nvim/init.lua
-- BOOTSTRAP LAZY.NVIM (Plugin Manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- in ~/.config/nvim/init.lua
vim.opt.smartcase = true
-- Add this line to use the system clipboard
vim.opt.clipboard = "unnamedplus"
-- BASIC NEOVIM OPTIONS
vim.g.mapleader = " "
vim.opt.mouse = "a"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
-- LOAD PLUGINS
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
})
-- Load custom keymaps
require("config.keymaps")
