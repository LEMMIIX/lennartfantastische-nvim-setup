return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons"
	},
	opts = {
		options = {
			icons_enabled = false,
			theme = 'seoul256-light',
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {
				{ require('lennartsfantastischecnofig.git-branch').get_branch },
				{
					'diff',
					symbols = { added = '+', modified = '~', removed = '-' }
				},
				{
					'diagnostics',
					symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' }
				},
			},
			lualine_c = {'filename'},
			lualine_x = {'encoding', 'filetype'},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
	},
}
