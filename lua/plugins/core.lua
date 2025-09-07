-- ~/.config/nvim/lua/plugins/core.lua
return {
  -- A nice theme to start with
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
		require("tokyonight").setup({
  style = "night", -- the darkest style
  transparent = false,
  on_colors = function(colors)
    colors.bg = "#000000"      -- main bg
    colors.bg_dark = "#000000" -- some sidebars/popups
  end,
  on_highlights = function(hl, colors)
    hl.Normal = { bg = "#000000" }
    hl.NormalNC = { bg = "#000000" }
    hl.SignColumn = { bg = "#000000" }
    hl.StatusLine = { bg = "#000000" }
    hl.WinSeparator = { bg = "#000000" }
    -- Un-comment to darken more UI elements if needed:
    -- hl.FloatBorder = { bg = "#000000" }
    -- hl.Pmenu = { bg = "#000000" }
  end,
})
      vim.cmd.colorscheme("tokyonight")
    end,
  },

  -- LSP & SERVER MANAGER
  { "williamboman/mason.nvim", config = true },
  "williamboman/mason-lspconfig.nvim",

  -- AUTOFORMATTING
  {
    "stevearc/conform.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      formatters_by_ft = {
        java = { "google-java-format" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- THE ALL-IN-ONE JAVA PLUGIN
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      require("java").setup()
      require("lspconfig").jdtls.setup({})
    end,
  },

  -- SNIPPET ENGINE & SNIPPETS COLLECTION
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/lua/custom/snippets" })
    end,
  },

  -- AUTOCOMPLETION ENGINE
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  -- CompetiTest.nvim and its dependency (consolidated and configured)
  {
    "xeluxee/competitest.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
        config = function()
      require("competitest").setup({
        -- Java compile/run commands
        compile_command = {
          java = { exec = "/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home/bin/javac", args = { "$(FNAME)" } },
        },
        run_command = {
          java = { exec = "/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home/bin/java", args = { "$(FNOEXT)" } },
        },
        -- UI setup
        runner_ui = {
          interface = "popup",
        },
        -- Testcase handling
        testcases_use_single_file = false,
        testcases_input_file_format = "$(FNOEXT)_input$(TCNUM).txt",
        testcases_output_file_format = "$(FNOEXT)_output$(TCNUM).txt",
        maximum_time = 5000,
        -- Competitive Companion integration
        companion_port = 27121,
        receive_print_message = true,
        received_files_extension = "java",
        -- THIS IS THE FIX: Use the sanitized name for the file
        received_problems_path = "$(CWD)/$(JAVA_TASK_CLASS).$(FEXT)",
        open_received_problems = true,
      })
    end,  },
}
