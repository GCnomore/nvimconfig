require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- Normal Mode
-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("n", "<leader>lf", function()
   vim.diagnostic.open_float { border = "rounded" }
end, {
   desc = "Floating diagnostic",
})

map("n", "j", "gj")
map("n", "k", "gk")

-- Neogit Mapping
map("n", "<leader>gg", ":Neogit<CR>", { desc = "Open Neogit" })

-- Insert Mode
map("i", "jk", "<ESC>")
map("i", "ppp", "<C-R>+")

-- Visual Mode
map("v", "<", "<gv", { desc = "Indent line" })
map("v", ">", ">gv", { desc = "Indent line" })
