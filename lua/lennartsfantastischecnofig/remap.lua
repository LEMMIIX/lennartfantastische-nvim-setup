vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)	-- project view

-- Zeilen verschieben und indent autom. anpassen
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")	-- Zeile runter
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")	-- Zeile hoch

-- Kopieren/einfügen
vim.keymap.set("x", "<leader>p", "\"_dP")

-- scheiß Hexenwerk - ausgewähltes Wort lässt simultan alle Vorkommnisse gleichzeitig bearbeiten
vim.keymap.set("n", "<leader>fr", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Fehlermeldung anzeigen
vim.keymap.set("n", "D", vim.diagnostic.open_float, opts)
