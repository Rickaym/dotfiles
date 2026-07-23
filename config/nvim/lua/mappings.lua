require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>gb", function()
  require("gitsigns").blame_line { full = true }
end, { desc = "Git blame line" })
map("n", "<leader>gB", "<cmd>Gitsigns blame<cr>", { desc = "Git blame buffer" })
map("n", "<leader>gt", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle inline blame" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
