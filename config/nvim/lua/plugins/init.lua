return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Specify flavor: latte, frappe, macchiato, or mocha
      })
    end,
  },
  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
      current_line_blame_opts = { delay = 300 },
    },
  },

  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      preview = {
        filetypes = { "markdown", "quarto", "rmd", "typst" },
        ignore_buftypes = {},
      },
    },
  },

  {
    "jbyuki/nabla.nvim",
    ft = "python",
    config = function()
      local function enable(buf)
        pcall(vim.treesitter.start, buf, "python")
        require("nabla").enable_virt { autogen = true, silent = true }
      end
      enable(vim.api.nvim_get_current_buf())
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "python",
        callback = function(args)
          enable(args.buf)
        end,
      })
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
