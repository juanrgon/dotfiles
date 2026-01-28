-- Neovim configuration - VS Code-like experience
-- Leader key must be set before plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Neovim 0.11 compatibility shim for plugins using deprecated API
if vim.treesitter.language.get_lang and not vim.treesitter.language.ft_to_lang then
  vim.treesitter.language.ft_to_lang = vim.treesitter.language.get_lang
end

-- Load core configuration
require("config.options")
require("config.keymaps")
require("config.lazy")

-- Load local config if it exists (for machine-specific settings)
local local_config = vim.fn.stdpath("config") .. "/local.lua"
if vim.fn.filereadable(local_config) == 1 then
  dofile(local_config)
end
