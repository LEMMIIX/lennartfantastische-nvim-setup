vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)	-- project view

-- Zeilen verschieben und indent autom. anpassen
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")	-- Zeile runter
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")	-- Zeile hoch
