-- Set leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- General settings
vim.g.have_nerd_font = true
vim.o.mouse = "a" -- Enable mouse
vim.o.undofile = true
vim.schedule(function()
  vim.o.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
end) -- Schedule to decrease startup-time.
vim.o.updatetime = 250 -- ms of inactivity before writing to swap file
vim.o.timeoutlen = 300 -- ms to wait for mapping sequence to complete
vim.o.confirm = true -- confirm exiting neovim if an operation would case unsaved changes to be lost

-- No mode show as it is already in the status Line
vim.o.showmode = false

vim.o.ignorecase = true -- Case-insensitive search
vim.o.smartcase = true -- Case-sensitive search if some letters are capitilazed

-- Text display settings
vim.o.cursorline = true
vim.o.breakindent = true -- wrapped lines do not continue visually indented
vim.o.list = true -- display whitecharacters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.inccommand = "split" -- preview substitutions
vim.o.scrolloff = 10

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Keymaps
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- clear search highlights
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Page jumping centers
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump page up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump page down" })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Install `lazy.nvim` plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end

-- Prepend lazypath to the runtimepaths
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  {
    import = "plugins",
  },
}, {
  ui = {
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = "⌘",
      config = "🛠",
      event = "📅",
      ft = "📂",
      init = "⚙",
      keys = "🗝",
      plugin = "🔌",
      runtime = "💻",
      require = "🌙",
      source = "📄",
      start = "🚀",
      task = "📌",
      lazy = "💤 ",
    },
  },
})
