return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        width = 50,
      },
      git = {
        enable = true,
        ignore = false,
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "html",
        "css",
        "bash",
        "lua",
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "markdown",
        "vim",
        "gitignore",
        "vue",
        "go",
        "gomod",
        "scss",
      },
      auto_install = true,
    },
  },
  { "tpope/vim-fugitive", lazy = false }, -- load a plugin at startup
  {
    "windwp/nvim-ts-autotag",
    init = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvimdev/indentmini.nvim",
    init = function()
      require("lazy").setup {
        "nvimdev/indentmini.nvim",
        event = "BufEnter",
        config = function()
          require("indentmini").setup()
        end,
      }
    end,
  },
  -- {
  --   "jose-elias-alvarez/null-ls.nvim",
  --   ft = "go",
  --   opts = function()
  --     return require "configs.null-ls"
  --   end,
  -- },
  { "nvim-lua/plenary.nvim" },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      local harpoon = require "harpoon"
      harpoon.setup()

      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end)
      vim.keymap.set("n", "<leader>r", function()
        harpoon:list():remove()
      end)
      vim.keymap.set("n", "<leader>c", function()
        harpoon:list():clear()
      end)
      vim.keymap.set("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)

      vim.keymap.set("n", "<C-h>", function()
        harpoon:list():select(1)
      end)
      vim.keymap.set("n", "<C-t>", function()
        harpoon:list():select(2)
      end)
      vim.keymap.set("n", "<C-n>", function()
        harpoon:list():select(3)
      end)
      vim.keymap.set("n", "<C-s>", function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "<C-S-P>", function()
        harpoon:list():prev()
      end)
      vim.keymap.set("n", "<C-S-N>", function()
        harpoon:list():next()
      end)
    end,
  },
}
