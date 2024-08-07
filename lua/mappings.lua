require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Custom
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<leader>tw", "<cmd>TailwindSort<cr>", { desc = "Sort Tailwind classes" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
