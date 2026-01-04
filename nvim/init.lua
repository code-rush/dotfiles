require("code-rush.core")
require("code-rush.lazy")

--[[
-- Set leader key (use space as leader key for convenience)
vim.g.maplead = " "

-- Lazy.nvim setup (plugin manager)
local lazypath  = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--Plugins
require("lazy").setup({
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, -- Syntax highlighting
  { "nvim-lualine/lualine.nvim" }, -- Statusline
  { "neovim/nvim-lspconfig" }, -- LSP support
  { "hrsh7th/nvim-cmp" }, -- Autocompletion
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- Fuzzy finder
})

-- Basic settings
vim.opt.mouse = "a"

-- Keybindings
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Save and quit shortcuts
keymap("n", "<leader>w", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)
--]]
