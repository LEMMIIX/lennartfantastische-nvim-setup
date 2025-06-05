return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- Setup
		harpoon:setup({})

		-- Telescope integration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			}):find()
		end

		-- Keymaps
		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add file" })
		vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Toggle menu" })
		vim.keymap.set("n", "<leader>h", function() toggle_telescope(harpoon:list()) end, { desc = "Harpoon: Open telescope" })

		-- Navigation
		--vim.keymap.set("n", "", function() harpoon:list():select(1) end, { desc = "Harpoon: File 1" })
		--vim.keymap.set("n", "", function() harpoon:list():select(2) end, { desc = "Harpoon: File 2" })
		--vim.keymap.set("n", "", function() harpoon:list():select(3) end, { desc = "Harpoon: File 3" })
		--vim.keymap.set("n", "", function() harpoon:list():select(4) end, { desc = "Harpoon: File 4" })

		-- Previous/Next
		vim.keymap.set("n", "<A-p>", function() harpoon:list():prev() end, { desc = "Harpoon: Previous" })
		vim.keymap.set("n", "<A-o>", function() harpoon:list():next() end, { desc = "Harpoon: Next" })
	end,
}
