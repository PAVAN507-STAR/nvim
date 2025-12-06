-- ~/.config/nvim/lua/config/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-----------------------------------------------------------------------
-- Save file on Ctrl+S (Insert + Normal + Visual)
-----------------------------------------------------------------------
keymap({ "i", "n", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save File" })

-----------------------------------------------------------------------
-- Select all
-----------------------------------------------------------------------
keymap("n", "<C-a>", "ggVG", opts)

-----------------------------------------------------------------------
-- Delete/Paste without affecting registers
-----------------------------------------------------------------------
keymap("n", "x", '"_x')
keymap("n", "<leader>d", '"_d')
keymap("v", "<leader>d", '"_d')
keymap("n", "<leader>p", '"0p')
keymap("n", "<leader>P", '"0P')
keymap("v", "<leader>p", '"0p')

-----------------------------------------------------------------------
-- Window management
-----------------------------------------------------------------------
keymap("n", "ss", ":split<CR>", opts)
keymap("n", "sv", ":vsplit<CR>", opts)

keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("n", "<C-w><left>", "<C-w><")
keymap("n", "<C-w><right>", "<C-w>>")
keymap("n", "<C-w><up>", "<C-w>+")
keymap("n", "<C-w><down>", "<C-w>-")

-----------------------------------------------------------------------
-- Telescope
-----------------------------------------------------------------------
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")

-----------------------------------------------------------------------
-- nvim-cmp + LuaSnip KEYMAPS
-----------------------------------------------------------------------
local luasnip = require("luasnip")
local cmp = require("cmp")

-- <Tab> → Next item OR expand/jump snippet
-- <S-Tab> → Previous item
-- <CR> → confirm completion OR expand snippet
keymap("i", "<Tab>", function()
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    return "<Tab>"
  end
end, { expr = true, silent = true })

keymap("i", "<S-Tab>", function()
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    return "<S-Tab>"
  end
end, { expr = true, silent = true })

keymap("i", "<CR>", function()
  if cmp.visible() then
    return cmp.mapping.confirm({ select = true })()
  elseif luasnip.expandable() then
    luasnip.expand()
  else
    return "<CR>"
  end
end, { expr = true, silent = true })

vim.keymap.set({ "i", "s" }, "<C-l>", function()
  if luasnip.jumpable(1) then luasnip.jump(1) end
end)

vim.keymap.set({ "i", "s" }, "<C-h>", function()
  if luasnip.jumpable(-1) then luasnip.jump(-1) end
end)

-----------------------------------------------------------------------
-- ToggleTerm Helper
-----------------------------------------------------------------------
local function run_command_in_toggleterm(cmd)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({
    cmd = cmd,
    direction = "float",
    close_on_exit = false,
  })
  term:toggle()
end

-----------------------------------------------------------------------
-- JAVA RUNNER (JDK 22)
-----------------------------------------------------------------------
local JAVA22_HOME = "/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home"

keymap("n", "<leader>rj", function()
  local fp = vim.fn.expand("%:p")
  local fd = vim.fn.expand("%:p:h")
  local cls = vim.fn.expand("%:t:r")
  run_command_in_toggleterm(
    "cd " .. fd
    .. " && clear && " .. JAVA22_HOME .. "/bin/javac " .. fp
    .. " && " .. JAVA22_HOME .. "/bin/java " .. cls
  )
end)

keymap("n", "<leader>ri", function()
  local fp = vim.fn.expand("%:p")
  local fd = vim.fn.expand("%:p:h")
  local cls = vim.fn.expand("%:t:r")
  run_command_in_toggleterm(
    "cd " .. fd
    .. " && clear && " .. JAVA22_HOME .. "/bin/javac " .. fp
    .. " && " .. JAVA22_HOME .. "/bin/java " .. cls .. " < input.txt"
  )
end)

-----------------------------------------------------------------------
-- C++ RUNNER
-----------------------------------------------------------------------
keymap("n", "<leader>rc", function()
  local fp = vim.fn.expand("%:p")
  local fd = vim.fn.expand("%:p:h")
  run_command_in_toggleterm(
    "cd " .. fd ..
    " && clear && g++ -std=c++17 " .. fp .. " -O2 -o a.out && ./a.out"
  )
end)

keymap("n", "<leader>rC", function()
  local fp = vim.fn.expand("%:p")
  local fd = vim.fn.expand("%:p:h")
  run_command_in_toggleterm(
    "cd " .. fd ..
    " && clear && g++ -std=c++17 " .. fp .. " -O2 -o a.out && ./a.out < input.txt"
  )
end)

-----------------------------------------------------------------------
-- SFML RUNNER
-----------------------------------------------------------------------
keymap("n", "<leader>rs", function()
  local fp = vim.fn.expand("%:p")
  local fd = vim.fn.expand("%:p:h")
  run_command_in_toggleterm(
    "cd " .. fd ..
    " && clear && clang++ -std=c++17 " .. fp ..
    " -o sfml_app -lsfml-graphics -lsfml-window -lsfml-system && ./sfml_app"
  )
end)

-----------------------------------------------------------------------
-- COMPETITEST
-----------------------------------------------------------------------
keymap("n", "<leader>rr", "<cmd>CompetiTest run<cr>")
keymap("n", "<leader>ra", "<cmd>CompetiTest add_testcase<cr>")
keymap("n", "<leader>rp", "<cmd>CompetiTest receive problem<cr>")
