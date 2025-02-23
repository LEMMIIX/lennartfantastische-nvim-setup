-- eigene settings

-- Misc
vim.opt.clipboard = "unnamedplus"	-- nvim und sys clipboard sind die selben
vim.opt.termguicolors = true	-- aktiviert termguicolors

-- indentation
local length = 4
vim.opt.tabstop = length
vim.opt.shiftwidth = length
vim.opt.softtabstop = length

-- Zeilennummern
vim.opt.number = true	-- In Dateien
vim.g.netrw_bufsettings = 'noma nomod nu nowrap ro nobl'	-- Im Explorer

vim.opt.relativenumber = true -- zeigt relative Zeilennummer von der Position vom cursor

-- Diagnostics
vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = '#d78700' })	-- Setzt WARN Farbe auf orange
