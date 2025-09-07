-- ~/.config/nvim/lua/plugins/ui.lua
return {
  -- Plugin 1: Your New "LUFFY" Dashboard
  {
    "goolord/alpha-nvim",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set header
      dashboard.section.header.val = {
        [[██╗     ██╗   ██╗███████╗███████╗██╗   ██╗]],
        [[██║     ██║   ██║██╔════╝██╔════╝╚██╗ ██╔╝]],
        [[██║     ██║   ██║█████╗  █████╗   ╚████╔╝ ]],
        [[██║     ██║   ██║██╔══╝  ██╔══╝    ╚██╔╝  ]],
        [[███████╗╚██████╔╝██║     ██║        ██║   ]],
        [[╚══════╝ ╚═════╝ ╚═╝     ╚═╝        ╚═╝   ]],
      }

      -- Set menu
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
        dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("g", "  Find Text", ":Telescope live_grep <CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
        dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy <CR>"),
        dashboard.button("q", "  Quit", ":qa <CR>"),
      }

      -- Send config to alpha
      alpha.setup(dashboard.opts)
    end,
  },
  -- Plugin 2: Neo-Tree (File Explorer)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true })
        end,
        desc = "Toggle File Explorer",
      },
    },
    opts = {
      window = {
        position = "left",
        width = 30,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
  -- Plugin 3: Noice.nvim (Command-line UI)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "rcarriga/nvim-notify" },
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline_popup",
      },
      messages = {
        enabled = true,
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
      },
    },
  },
}
