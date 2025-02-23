local M = {}

-- Define highlight groups directly in the module
vim.api.nvim_set_hl(0, 'GitBranchNormal', { fg = '#88b493' })
vim.api.nvim_set_hl(0, 'GitBranchDetached', { fg = '#ee6600' })

local branch_cache = nil  -- Stores the branch result

local function get_git_branch()
	if branch_cache ~= nil then
		return branch_cache  -- Return cached value
	end

	local handle = io.popen('git rev-parse --abbrev-ref HEAD 2> '..(vim.fn.has('win32') == 1 and 'nul' or '/dev/null'))
	if not handle then
		branch_cache = ''
		return ''
	end

	local branch = handle:read('*a'):gsub('\n', '')
	handle:close()

	if branch == 'HEAD' then
		branch = '###DETACHED HEAD###'
	elseif branch ~= '' then
		branch = '⑂ ('..branch..')'
	else
		branch = '---' -- Optional branch icon
	end

	branch_cache = branch  -- Cache the result
	return branch
end

-- Expose through v:lua
function _G.git_branch_status()
	return get_git_branch()
end

return M
