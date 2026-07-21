return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>y", "<cmd>Yazi<cr>", desc = "Open yazi at current file" },
      { "<leader>Y", "<cmd>Yazi cwd<cr>", desc = "Open yazi in working directory" },
    },
    opts = {
      open_for_directories = false,
      -- on quit, set nvim's cwd to wherever yazi ended up
      change_neovim_cwd_on_close = true,
    },
  },
}
