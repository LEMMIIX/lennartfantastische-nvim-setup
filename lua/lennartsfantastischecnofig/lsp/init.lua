local lsp_servers = {
	clangd = require("lennartsfantastischecnofig.lsp.clangd"),
	lua_ls = require("lennartsfantastischecnofig.lsp.lua-language-server"),
}

for name, config in pairs(lsp_servers) do
	vim.lsp.config[name] = config
end

vim.lsp.enable({ "clangd", "lua_ls" })
