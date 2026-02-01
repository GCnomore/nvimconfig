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

-- Diffview
map("n", "<leader>do", "<cmd>DiffviewOpen<cr>", { desc = "Diffview Open" })
map("n", "<leader>dc", "<cmd>DiffviewClose<cr>", { desc = "Diffview Close" })
map("n", "<leader>df", "<cmd>DiffviewFileHistory %<cr>", { desc = "Diffview File History" })

-- Neogit Mapping
map("n", "<leader>gg", ":Neogit<CR>", { desc = "Open Neogit" })

-- Insert Mode
map("i", "jk", "<ESC>")
map("i", "ppp", "<C-R>+")

-- Visual Mode
map("v", "<", "<gv", { desc = "Indent line" })
map("v", ">", ">gv", { desc = "Indent line" })
