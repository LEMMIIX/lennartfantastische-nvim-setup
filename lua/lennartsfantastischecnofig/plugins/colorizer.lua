return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",

	config = function ()
		require("colorizer").setup({
			filetypes = { "*" },
			user_default_options = {
				RGB = true,
				RRGGBB = true,
				names = false,		-- "red"
				RRGGBBAA = true,
				rgb_fn = true,		-- "rgb(255, 0, 0)"
				hsl_fn = true,		-- "hsl(0, 100%, 50%)"
				css = true,
				css_fn = true,
			},

			xterm = true,
		})
	end
}
