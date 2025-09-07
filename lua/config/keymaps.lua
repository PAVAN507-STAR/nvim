-- ~/.config/nvim/lua/config/keymaps.lua
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
-- PASTE THE PATH YOU COPIED FROM YOUR TERMINAL HERE
local JAVA22_HOME = "/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home"
-- Helper function that uses ToggleTerm's core API (defined once)
local function run_command_in_toggleterm(cmd)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({
    cmd = cmd,
    direction = "float",
    close_on_exit = false,
  })
  term:toggle()
end
-- Save file on <C-s> in all modes
keymap.set({ "i", "n", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save File" })
-- Preserve registers when pasting, deleting, etc.
keymap.set("n", "x", '"_x')
keymap.set("n", "<Leader>p", '"0p')
keymap.set("n", "<Leader>P", '"0P')
keymap.set("v", "<Leader>p", '"0p')
keymap.set("n", "<Leader>d", '"_d')
keymap.set("v", "<Leader>d", '"_d')
-- Select all
keymap.set("n", "<C-a>", "ggVG")
-- Window management
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Navigate between split windows with Ctrl + h/j/k/l (NEW MAPPINGS)
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)
-- Close current split window
keymap.set("n", "<leader>wc", "<C-w>c", { desc = "Close Current Split" })
-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")
-- Java-specific commands using EXPLICIT paths to Java 22 (consolidated, no duplicates)
keymap.set("n", "<leader>rj", function()
  local file_path = vim.fn.expand("%:p") -- Full path to the file
  local file_dir = vim.fn.expand("%:p:h") -- Directory of the file
  local class_name = vim.fn.expand("%:t:r") -- Class name without extension
  local javac_cmd = JAVA22_HOME .. "/bin/javac"
  local java_cmd = JAVA22_HOME .. "/bin/java"
  run_command_in_toggleterm("cd " .. file_dir .. " && clear && " .. javac_cmd .. " " .. file_path .. " && " .. java_cmd .. " " .. class_name)
end, { desc = "Run Java in ToggleTerm" })
keymap.set("n", "<leader>ri", function()
  local file_path = vim.fn.expand("%:p")
  local file_dir = vim.fn.expand("%:p:h")
  local class_name = vim.fn.expand("%:t:r")
  local javac_cmd = JAVA22_HOME .. "/bin/javac"
  local java_cmd = JAVA22_HOME .. "/bin/java"
  run_command_in_toggleterm("cd " .. file_dir .. " && clear && " .. javac_cmd .. " " .. file_path .. " && " .. java_cmd .. " " .. class_name .. " < input.txt")
end, { desc = "Run Java with Input in ToggleTerm" })
-- #############################################
-- ## CompetiTest Keymaps (NEWLY ADDED) ##
-- #############################################
keymap.set("n", "<leader>rr", "<cmd>CompetiTest run<cr>", { desc = "Run CompetiTest" })
keymap.set("n", "<leader>ra", "<cmd>CompetiTest add_testcase<cr>", { desc = "Add CompetiTest testcase" })
keymap.set("n", "<leader>rp", "<cmd>CompetiTest receive problem<cr>", { desc = "Receive CompetiTest problem" })
-- Debugging commands
keymap.set("n", "<leader>b", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
keymap.set("n", "<leader>dc", function() require("dap").continue() end, { desc = "Start/Continue Debugger" })
