return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  { import = "nvchad.blink.lazyspec" },

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
        "liquid",
      },

      auto_install = true,

      -- highlight 설정 추가
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local filename = vim.api.nvim_buf_get_name(buf)
          if filename == "" then
            return false
          end
          local max_filesize = 1000 * 1024 -- 1MB
          local ok, stats = pcall(vim.loop.fs_stat, filename)
          if ok and stats and stats.size > max_filesize then
            return true
          end
          if filename:match "%.min%.js$" or filename:match "%.min%.css$" or filename:match "%.min%.html$" then
            return true
          end
          local lines = vim.fn.readfile(filename, "", 100)
          for _, line in ipairs(lines) do
            if #line > 500 then
              return true
            end
          end
        end,
        additional_vim_regex_highlighting = false,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function() end,
  },

  { "tpope/vim-fugitive", lazy = false },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  -- 🛠️ 수정된 부분: indentmini 설정
  {
    "nvimdev/indentmini.nvim",
    event = "BufEnter",
    config = function()
      require("indentmini").setup()
    end,
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      vim.g.skip_ts_context_commentstring_module = true
      require("ts_context_commentstring").setup {}
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      return require "configs.null-ls"
    end,
  },

  { "nvim-lua/plenary.nvim" },

  {
    "Djancyp/better-comments.nvim",
    lazy = true,
    init = function()
      require("better-comment").Setup {
        tags = {
          { name = "TODO", fg = "white", bg = "#0a7aca", bold = true, virtual_text = "" },
          { name = "FIX", fg = "white", bg = "#f44747", bold = true, virtual_text = "!" },
          { name = "WARNING", fg = "#FFA500", bg = "", bold = false, virtual_text = "" },
          { name = "!", fg = "#f44747", bg = "", bold = true, virtual_text = "" },
        },
      }
    end,
  },

  {
    "heavenshell/vim-jsdoc",
    ft = { "javascript", "javascript.jsx", "typescript", "typescript.tsx" },
    build = "make install",
  },

  { "nvchad/volt", lazy = true },
  { "nvchad/minty", cmd = { "Shades", "Huefy" } },
  { "sindrets/diffview.nvim", lazy = false },

  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" },
    lazy = false,
    config = function()
      require("neogit").setup {
        kind = "floating",
        floating_window = { border = "rounded", width = 0.9, height = 0.85 },
        integrations = { diffview = true },
      }
    end,
  },

  {
    "toppair/peek.nvim",
    event = { "VeryLazy" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup { app = "browser" }
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },

  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup {
        lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      }
    end,
  },

  {
    "turbio/bracey.vim",
    cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
    build = "npm install --prefix server",
  },

  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },

  {
    "yamatsum/nvim-cursorline",
    config = function()
      require("nvim-cursorline").setup {
        cursorline = { enable = true, number = false },
        cursorword = { enable = true, min_length = 3, hl = { underline = true } },
      }
    end,
  },

  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    -- keys 설정은 기존과 동일하게 유지
  },

  {
    "prettier/vim-prettier",
    build = "npm install --legacy-peer-deps",
    ft = {
      "javascript",
      "typescript",
      "css",
      "less",
      "scss",
      "json",
      "graphql",
      "markdown",
      "vue",
      "yaml",
      "html",
      "liquid",
    },
    config = function()
      vim.g["prettier#autoformat"] = 0
      vim.g["prettier#autoformat_require_pragma"] = 0
    end,
  },
}
