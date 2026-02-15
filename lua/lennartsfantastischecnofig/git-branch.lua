local M = {
	branch_cache = nil,
	initialized = false,
}

local function async_get_git_branch()
	-- Verhindere mehrfache Jobs im selben Puffer
	if M.initialized then
		return
	end
	M.initialized = true

	local cmd = { 'git', 'rev-parse', '--abbrev-ref', 'HEAD' }

	vim.fn.jobstart(cmd, {
		on_stdout = function(_, data)
			if not data or #data < 1 or (data[1] == '' and #data == 1) then
				return
			end
			local branch = data[1]:gsub('\n', '')
			if branch == 'HEAD' then
				M.branch_cache = '###DETACHED###'
			elseif branch ~= '' then
				M.branch_cache = '⑂ (' .. branch .. ')'
			end
			-- lualine neu zeichnen, sobald Branch da ist
			vim.cmd('redrawstatus')
		end,
		on_exit = function(_, exit_code)
			if exit_code ~= 0 and M.branch_cache == nil then
				M.branch_cache = '(not a git repo)'
				vim.cmd('redrawstatus')
			end
		end,
		stdout_buffered = true,
	})
end

-- Funktion, die in lualine aufgerufen wird (gibt immer den aktuellen Cache zurÃ¼ck)
function M.get_branch()
	if not M.initialized then
		async_get_git_branch()
		return '' -- Platzhalter, bis asynchrone Antwort kommt
	end
	return M.branch_cache or ''
end

-- Bei Verzeichniswechsel oder Pufferwechsel neu initialisieren
function M.reset()
	M.initialized = false
	M.branch_cache = nil
	-- Sofort neuen Branch laden (z.B. beim nÃ¤chsten Redraw)
	async_get_git_branch()
end

-- Autocmd fÃ¼r Verzeichniswechsel und BufEnter
vim.api.nvim_create_autocmd({ 'DirChanged', 'BufEnter' }, {
	callback = function()
		M.reset()
	end,
})

return M
