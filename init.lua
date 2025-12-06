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

-----------------------------------------------------------------------
-- AUTO TEMPLATE FOR NEW C++ FILES (GUARANTEED LOADS)
-----------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  callback = function()
    local template = {
      "#include <bits/stdc++.h>",
      "using namespace std;",
      "#define int long long",
      "#define endl \"\\n\"",
      "#define mod 1000000007;",
      "const int inf = 1e18;",
      "",
      "",
      "/*",
      "Observations",
      "    If I can solve it, how would the soln be?",
      "*/",
      "",
      "void solve() {",
      "    ",
      "}",
      "",
      "signed main() {",
      "    ios::sync_with_stdio(false);",
      "    cin.tie(nullptr);",
      "",
      "    int t;",
      "    cin >> t;",
      "    while (t--) {",
      "        solve();",
      "    }",
      "    return 0;",
      "}",
      "",
      "// Golden Rules",
      "/*",
      "    Solutions are simple.",
      "    Proofs are simple.",
      "    Implementations are simple.",
      "*/",
    }

    vim.api.nvim_buf_set_lines(0, 0, -1, false, template)

    -- Move cursor inside solve()
    vim.api.nvim_win_set_cursor(0, {18, 4})
  end,
})

