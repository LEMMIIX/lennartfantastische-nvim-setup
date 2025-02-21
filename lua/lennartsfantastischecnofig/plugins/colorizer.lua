return {
	"norcalli/nvim-colorizer.lua",
	event = "BufReadPre",
	config = function()
		require("colorizer").setup({
			-- Default options
			filetypes = { "*" },  -- Enable for all file types
			user_default_options = {
				RGB = true,         -- Enable RGB color codes
				RRGGBB = true,      -- Enable RRGGBB color codes
				names = true,       -- Enable color names (e.g., "red")
				RRGGBBAA = true,    -- Enable RRGGBBAA color codes
				rgb_fn = true,      -- Enable RGB functions (e.g., "rgb(255, 0, 0)")
				hsl_fn = true,      -- Enable HSL functions (e.g., "hsl(0, 100%, 50%)")
				css = true,         -- Enable CSS color codes
				css_fn = true,      -- Enable CSS color functions
				mode = "background", -- Set the display mode (background, foreground, or virtualtext)
			},
		})
		-- Attach colorizer to all buffers
		vim.defer_fn(function()
			vim.cmd("ColorizerAttachToBuffer")
		end, 0)
	end,
}
