-- Floating window의 기본 테두리를 rounded로 강제 고정
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded" -- 테두리가 없으면 rounded로 강제
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

vim.diagnostic.config({
  float = {
    border = "rounded",
    focusable = false,
  },
})


-- NvChad의 기본 설정(on_attach, capabilities)을 가져옵니다.
local base = require "nvchad.configs.lspconfig"
local on_attach = base.on_attach
local on_init = base.on_init
local capabilities = base.capabilities

local util = require "lspconfig/util"

-----------------------------------------------------------
-- 1. PATH 강제 주입 (Cargo 문제 해결의 핵심)
-----------------------------------------------------------
local home = vim.fn.expand "$HOME"
local cargo_bin = home .. "/.cargo/bin"

if vim.fn.isdirectory(cargo_bin) == 1 then
  vim.env.PATH = cargo_bin .. ":" .. vim.env.PATH
end

-----------------------------------------------------------
-- 2. 기본 설정만 사용하는 서버들
-----------------------------------------------------------
local servers = {
  "html",
  "cssls",
  "tailwindcss",
  "pylsp",
  "jsonls",
}

-- 반복문으로 기본 서버들을 일괄 setup 합니다.
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    capabilities = capabilities,
    on_attach = on_attach,
    on_init = on_init,
  })

  vim.lsp.enable(lsp)
end

-----------------------------------------------------------
-- 3. 커스텀 설정이 필요한 서버들 (Nvim 0.11+ 스타일)
-----------------------------------------------------------

-- [Rust Analyzer]
vim.lsp.config("rust_analyzer", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = vim.fs.root(0, { "Cargo.toml", "rust-project.json" }),
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
    },
  },
})
vim.lsp.enable "rust_analyzer"

-- [TypeScript / Javascript]
vim.lsp.config("ts_ls", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "liquid" },
  init_options = {
    preferences = {
      includeInlayParameterNameHints = "all",
    },
  },
})
vim.lsp.enable "ts_ls"

-- [Go]
vim.lsp.config("gopls", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  settings = {
    gopls = {
      completeUnimported = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
})
vim.lsp.enable "gopls"

-- [Shopify]
vim.lsp.config("shopify_theme_ls", {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "shopify", "theme", "language-server" },
  filetypes = { "liquid" },
})
vim.lsp.enable "shopify_theme_ls"
