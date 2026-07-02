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
-- Auto-fix
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP Code Action' })

-- GoTo
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { noremap = true, silent =false })

-- resize
vim.keymap.set('n', '<A-Left>',  '<C-w><', { desc = 'Decrease width' })
vim.keymap.set('n', '<A-Right>', '<C-w>>', { desc = 'Increase width' })
vim.keymap.set('n', '<A-Up>',    '<C-w>+', { desc = 'Increase height' })
vim.keymap.set('n', '<A-Down>',  '<C-w>-', { desc = 'Decrease height' })
