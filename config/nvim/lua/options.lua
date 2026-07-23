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
  paste = {
    ["+"] = osc52.paste "+",
    ["*"] = osc52.paste "*",
  },
}
