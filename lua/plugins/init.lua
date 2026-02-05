return {
  {
    "stevearc/conform.nvim",
    -- 예전 스타일: opts 대신 config 함수 내부에서 require
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- 예전 스타일: NvChad defaults 불러오기
      require("nvchad.configs.lspconfig").defaults()
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
      -- 내용은 현재의 개선된 하이라이트 로직 유지
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local filename = vim.api.nvim_buf_get_name(buf)
          if filename == "" then
            return false
          end

          local max_filesize = 1000 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, filename)
          if ok and stats and stats.size > max_filesize then
            return true
          end

          if filename:match "%.min%.js$" or filename:match "%.min%.css$" or filename:match "%.min%.html$" then
            return true
          end

          local lines = vim.fn.readfile(filename, "", 100)
          for _, line in ipairs(lines) do
            if #line > 10000 then
              return true
            end
            for word in line:gmatch "%S+" do
              if #word > 1000 then
                return true
              end
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
    -- 예전 스타일: config 대신 init 사용
    init = function()
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = true,
        },
        per_filetype = {
          ["liquid"] = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = true,
          },
        },
      }
    end,
  },

  {
    "windwp/nvim-autopairs",
    -- 예전 스타일: config 대신 init 사용
    init = function()
      require("nvim-autopairs").setup()
    end,
  },

  {
    "nvimdev/indentmini.nvim",
    -- 예전 스타일: config 대신 init 사용
    init = function()
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
    -- 예전 스타일: init에서 setup 호출 추가
    init = function()
      require("null-ls").setup {}
    end,
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
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
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
