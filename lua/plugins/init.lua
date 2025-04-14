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
            width = 35,
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
      "windwp/nvim-autopairs",
      init = function()
         require("nvim-autopairs").setup()
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

   {
      "JoosepAlviste/nvim-ts-context-commentstring",
      config = function()
         vim.g.skip_ts_context_commentstring_module = true
         require("ts_context_commentstring").setup {}
      end,
   },
   -- {
   --    "numToStr/Comment.nvim",
   --    opts = {
   --       pre_hook = function(ctx)
   --          -- Only set this up for filetypes that require context-aware commenting
   --          if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == "javascriptreact" then
   --             local commentstring = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
   --             return commentstring(ctx)
   --          end
   --       end,
   --    },
   -- },

   --{
   --  "jose-elias-alvarez/null-ls.nvim",
   -- ft = "go",
   -- opts = function()
   --  return require "configs.null-ls"
   --end,
   --},
   {
      "nvimtools/none-ls.nvim",
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
               {
                  name = "TODO",
                  fg = "white",
                  bg = "#0a7aca",
                  bold = true,
                  virtual_text = "",
               },
               {
                  name = "FIX",
                  fg = "white",
                  bg = "#f44747",
                  bold = true,
                  virtual_text = "This is virtual Text from FIX",
               },
               {
                  name = "WARNING",
                  fg = "#FFA500",
                  bg = "",
                  bold = false,
                  virtual_text = "",
               },
               {
                  name = "!",
                  fg = "#f44747",
                  bg = "",
                  bold = true,
                  virtual_text = "",
               },
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

   {
      "nvchad/minty",
      cmd = { "Shades", "Huefy" },
   },
   {
      "sindrets/diffview.nvim",
      lazy = false,
   },
   {
      "NeogitOrg/neogit",
      dependencies = {
         "nvim-lua/plenary.nvim", -- required
         "sindrets/diffview.nvim", -- optional - Diff integration

         -- Only one of these is needed.
         "nvim-telescope/telescope.nvim", -- optional
         "ibhagwan/fzf-lua", -- optional
         "echasnovski/mini.pick", -- optional
      },
      -- config = true,
      lazy = false,
      config = function()
         require("neogit").setup {
            kind = "floating",
            floating_window = {
               border = "rounded", -- Options: "single", "double", "rounded", "solid", "shadow"
               width = 0.9, -- Adjust width as a proportion of the editor's width
               height = 0.85, -- Adjust height as a proportion of the editor's height
            },
            integrations = {
               diffview = true,
            },
         }
      end,
   },

   -- Markdown previewer
   {
      "toppair/peek.nvim",
      event = { "VeryLazy" },
      build = "deno task --quiet build:fast",
      config = function()
         require("peek").setup {
            app = "browser",
         }
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
            lastplace_ignore_filetype = {
               "gitcommit",
               "gitrebase",
               "svn",
               "hgcommit",
            },
            lastplace_open_folds = true,
         }
      end,
   },

   -- html, css, js live edit
   {
      "turbio/bracey.vim",
      cmd = { "Bracey", "BracyStop", "BraceyReload", "BraceyEval" },
      build = "npm install --prefix server",
   },

   {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      config = function()
         require("nvim-surround").setup {
            -- Configuration here, or leave empty to use defaults
         }
      end,
   },

   {
      "yamatsum/nvim-cursorline",
      config = function()
         require("nvim-cursorline").setup {
            cursorline = {
               enable = true,
               number = false,
            },
            cursorword = {
               enable = true,
               min_length = 3,
               hl = { underline = true },
            },
         }
      end,
   },
}
