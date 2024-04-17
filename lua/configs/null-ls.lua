local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting
local lint = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
   sources = {
      formatting.prettier,
      formatting.stylua,
      formatting.gofumpt,
      formatting.goimports,
      lint.shellcheck,
   },
   on_attach = function (client, bufnr)
      if client.supports_method("textDocument/formatting") then
         -- Disable formatting on save
         vim.cmd([[
             augroup NoFormatOnSave
                 autocmd!
             augroup END
         ]])
      -- vim.api.nvim_clear_autocmds({
      --    group = augroup,
      --    buffer = bufnr,
      -- })
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --    group = augroup,
      --    buffer = bufnr,
      --    callback = function ()
      --       vim.lsp.buf.format({ bufnr = bufnr })
      --    end
      -- })
      end
   end
}

null_ls.setup {
   debug = true,
   sources = opts.sources,
   on_attach = opts.on_attach,
}

return opts
