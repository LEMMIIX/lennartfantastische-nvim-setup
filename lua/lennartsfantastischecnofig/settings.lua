-- eigene settings

-- Misc
vim.opt.clipboard = "unnamedplus"	-- nvim und sys clipboard sind die selben
vim.opt.termguicolors = true	-- aktiviert termguicolors
vim.opt.hlsearch = true		-- zeigt ALLE Ergebnisse in Datei an wenn 'true'
vim.opt.incsearch = true	-- incremental search (zeigt Suchergebnisse beim schreiben an)
vim.opt.scrolloff = 7
vim.opt.updatetime = 50
vim.opt.colorcolumn = "112"

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

-- Statusline
require('lennartsfantastischecnofig.stl_gitbranch')

vim.cmd('highlight Statusline guibg=#e3ad98')

local statusline = {
	'%#Statusline#',
	'%t',
	'%=',
	'%-5{%v:lua.vim.api.nvim_get_mode().mode%}',
	'%{v:lua.git_branch_status()}',
	'%*',
	'%=',
	'%{&filetype}',
	' %3l:%-2c ',
}

vim.o.statusline = table.concat(statusline,'')

-- Reset terminal colors on exit
vim.api.nvim_create_autocmd("VimLeave", {
	callback = function()
		vim.opt.guicursor = "a:block-blinkon0"
		os.execute("printf '\033[0m'")  -- Reset terminal colors
	end,
})
