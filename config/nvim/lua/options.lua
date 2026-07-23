require "nvchad.options"

-- add yours here!

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!

vim.opt.virtualedit = "onemore"

-- Route the system clipboard through OSC 52 so yanks reach the local
-- machine over SSH/tmux. Yank with y in visual mode to copy.
vim.opt.clipboard = "unnamedplus"

local osc52 = require "vim.ui.clipboard.osc52"
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = osc52.copy "+",
    ["*"] = osc52.copy "*",
  },
  -- osc52.paste queries the terminal and blocks when it does not reply.
  -- Paste from the unnamed register instead so P never waits on the terminal.
  paste = {
    ["+"] = function()
      return vim.split(vim.fn.getreg '"', "\n")
    end,
    ["*"] = function()
      return vim.split(vim.fn.getreg '"', "\n")
    end,
  },
}
