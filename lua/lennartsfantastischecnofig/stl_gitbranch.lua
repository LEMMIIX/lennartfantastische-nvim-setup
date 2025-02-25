local M = {}

-- Store the branch cache and initialized state
M.branch_cache = nil
M.initialized = false

-- Asynchronously get git branch information
local function async_get_git_branch()
	-- Skip if already initialized
	if M.initialized then
		return
	end

	-- Mark as initialized to prevent multiple calls
	M.initialized = true

	-- Get the appropriate null device for the platform
	local null_device = vim.fn.has('win32') == 1 and 'nul' or '/dev/null'
	local cmd = {'git', 'rev-parse', '--abbrev-ref', 'HEAD'}

	-- Start async job to check branch
	vim.fn.jobstart(cmd, {
		on_stdout = function(_, data, _)
			if not data or #data < 1 or (data[1] == "" and #data == 1) then
				return
			end

			local branch = data[1]:gsub('\n', '')

			if branch == 'HEAD' then
				M.branch_cache = '###DETACHED HEAD###'
			elseif branch ~= '' then
				M.branch_cache = '⑂ (' .. branch .. ')'
			end
		end,
		on_exit = function(_, exit_code)
			-- Only set to "not a git repo" if we haven't already set it and the command failed
			if exit_code ~= 0 and M.branch_cache == nil then
				M.branch_cache = "(not a git repo)"
			end
		end,
		stdout_buffered = true
	})
end

-- Expose for statusline
function _G.git_branch_status()
	-- Initialize on first call if not already done
	if not M.initialized then
		async_get_git_branch()
		return ""  -- Return empty string initially instead of a loading message
	end

	-- Return cache or empty string
	return M.branch_cache or ""
end

return M
