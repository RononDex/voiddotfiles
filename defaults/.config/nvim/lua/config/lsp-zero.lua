local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({select = false}),
	['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
	['<C-Space>'] = cmp.mapping.complete(),
  }),
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = {'abbr', 'kind', 'menu'},
    format = require('lspkind').cmp_format({
      mode = 'symbol', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
    })
  }
})

require("mason").setup({
		ensure_installed = { 
				"lua_ls", 
				"csharp-language-server", 
				"csharpier", 
				"bash-language-server",
				"jdtls",
				"java-debug-adapter",
				"java-test",
		},
})
require('mason-lspconfig').setup({
		ensure_installed = { 
				"lua_ls", 
				"jdtls",
				"omnisharp",
				"clangd",
				"html",
		},
  handlers = {
    lsp_zero.default_setup,
  },
})
