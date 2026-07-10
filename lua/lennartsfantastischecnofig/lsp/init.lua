local lsp_servers = {
	clangd = require("lennartsfantastischecnofig.lsp.clangd"),
	lua_ls = require("lennartsfantastischecnofig.lsp.lua-language-server"),
	texlab = require("lennartsfantastischecnofig.lsp.texlab"),
}

local has_coq, coq = pcall(require, "coq")

for name, config in pairs(lsp_servers) do
	if has_coq then
		config.capabilities = vim.tbl_deep_extend(
			"force",
			config.capabilities or {},
			coq.lsp_ensure_capabilities({})
		)
	end

	vim.lsp.config[name] = config
end

vim.lsp.enable({ "clangd", "lua_ls", "texlab" })
