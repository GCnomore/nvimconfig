-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
   theme = "everblush",

   -- hl_override = {
   -- Comment = { italic = true },
   -- ["@comment"] = { italic = true },
   -- },
}

vim.api.nvim_set_hl(0, "St_relativepath", { bg = "#333333" }) -- Adjust colors as needed
local stbufnr = function()
   return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
end

M.ui = {
   telescope = {
      style = "bordered",
   },
   statusline = {
      separator_style = "default",
      theme = "default",
      order = { "mode", "relativepath", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
      modules = {
         relativepath = function()
            local path = vim.api.nvim_buf_get_name(stbufnr())

            if path == "" then
               return ""
            end

            -- Get the last two components of the directory path
            local components = vim.split(vim.fn.fnamemodify(path, ":h"), "/")
            local depth = math.min(2, #components)

            local last_two_path = table.concat(components, " / ", #components - depth + 1, #components)

            return "%#St_relativepath#  " .. last_two_path .. " /"
         end,
      },
   },
}

M.colorify = {
   enabled = true,
   mode = "bg", -- fg, bg, virtual
   -- virt_text = "󱓻 ",
   highlight = { hex = true, lspvars = true },
}

return M
