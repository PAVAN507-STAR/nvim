-- ~/.config/nvim/lua/plugins/core.lua
return {

  -----------------------------------------------------------------------
  -- 🌈 THEME: Catppuccin (Black Background)
  -----------------------------------------------------------------------

{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",   -- night / storm / moon / day
      transparent = false,

      -- These let us override UI elements
      on_colors = function(colors)
        -- keep original syntax colors (do nothing)
        return colors
      end,

      on_highlights = function(hl, colors)
        --------------------------------------------------------------------
        -- FORCE FULL BLACK UI WHILE KEEPING TOKYONIGHT SYNTAX
        --------------------------------------------------------------------
        hl.Normal = { bg = "#000000", fg = colors.fg }
        hl.NormalNC = { bg = "#000000", fg = colors.fg }

        hl.SignColumn = { bg = "#000000" }
        hl.LineNr = { bg = "#000000", fg = colors.dark5 }
        hl.CursorLine = { bg = "#000000" }
        hl.CursorLineNr = { bg = "#000000", fg = colors.blue }

        hl.StatusLine = { bg = "#000000", fg = colors.blue }
        hl.TabLineFill = { bg = "#000000" }
        hl.WinSeparator = { bg = "#000000", fg = "#222222" }

        -- Diagnostics background clean
        hl.DiagnosticVirtualTextError = { bg = "#000000", fg = colors.red }
        hl.DiagnosticVirtualTextWarn  = { bg = "#000000", fg = colors.yellow }
        hl.DiagnosticVirtualTextInfo  = { bg = "#000000", fg = colors.blue }
        hl.DiagnosticVirtualTextHint  = { bg = "#000000", fg = colors.green }
      end,
    })

    -- APPLY TOKYONIGHT
    vim.cmd.colorscheme("tokyonight")
  end,
},

  -----------------------------------------------------------------------
  -- 🔍 TELESCOPE (Fuzzy Finder)
  -----------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
    end,
  },

  -----------------------------------------------------------------------
  -- 🌳 TREESITTER (Syntax Highlighting)
  -----------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },

  -----------------------------------------------------------------------
  -- 🔄 AUTOPAIRS (Bracket autocomplete)
  -----------------------------------------------------------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -----------------------------------------------------------------------
  -- 📝 SNIPPETS: LuaSnip + friendly snippets + your custom snippets
  -----------------------------------------------------------------------
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load({
        paths = vim.fn.stdpath("config") .. "/lua/custom/snippets",
      })
    end,
  },

  -----------------------------------------------------------------------
  -- 📦 TOGGLETERM (Floating Terminal)
  -----------------------------------------------------------------------
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        direction = "float",
        float_opts = { border = "rounded" },
      })
    end,
  },

  -----------------------------------------------------------------------
  -- 🏁 COMPETITEST (Competitive Programming)
  -----------------------------------------------------------------------
  {
    "xeluxee/competitest.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("competitest").setup({
        compile_command = {
          cpp = {
            exec = "g++",
            args = { "-std=c++17", "$(FNAME)", "-O2", "-Wall", "-o", "$(FNOEXT)" },
          },
          java = {
            exec = "/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home/bin/javac",
            args = { "$(FNAME)" },
          },
        },
        run_command = {
          cpp = { exec = "./$(FNOEXT)" },
          java = {
            exec = "/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home/bin/java",
            args = { "$(FNOEXT)" },
          },
        },
      })
    end,
  },

  -----------------------------------------------------------------------
  -- 🔥 git-conflict (resolve merge conflicts)
  -----------------------------------------------------------------------
  { "akinsho/git-conflict.nvim", version = "*", config = true },

  -----------------------------------------------------------------------
  -- 🎯 Grapple (Jump between important files)
  -----------------------------------------------------------------------
  { "cbochs/grapple.nvim", config = true },

  -----------------------------------------------------------------------
  -- 💾 Auto-save
  -----------------------------------------------------------------------
  { "Pocco81/auto-save.nvim", config = true },

  -----------------------------------------------------------------------
  -- 💼 Auto-session (restore last session)
  -----------------------------------------------------------------------
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        auto_session_enabled = true,
      })
    end,
  },

  -----------------------------------------------------------------------
  -- 🧵 Overseer (task/job runner)
  -----------------------------------------------------------------------
  { "stevearc/overseer.nvim", config = true },

  -----------------------------------------------------------------------
  -- 🍥 Incline (winbar replacement)
  -----------------------------------------------------------------------
  {
    "b0o/incline.nvim",
    config = function()
      require("incline").setup()
    end,
  },

  -----------------------------------------------------------------------
  -- 🔧 MASON (Installer for LSP, DAP, Linters, Formatters)
  -----------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    config = true,
  },

  -----------------------------------------------------------------------
  -- 🔧 Mason-LSPConfig (Auto bridge between Mason & LSPConfig)
  -----------------------------------------------------------------------
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd",
          "jdtls",
          "pyright",
          "tsserver",
        },
      })
    end,
  },

  -----------------------------------------------------------------------
  -- 🧠 LSPCONFIG (Native LSP)
  -----------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = require("lspconfig")

      lsp.clangd.setup({})
      lsp.jdtls.setup({})
      lsp.pyright.setup({})
      lsp.tsserver.setup({})
    end,
  },

  -----------------------------------------------------------------------
  -- ⚡ AUTOCOMPLETION (nvim-cmp)
  -----------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
}
