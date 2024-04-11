require("neotest").setup({
	adapters = {
		require("neotest-java")({
			ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
			-- junit_jar = "path/to/junit-standalone.jar",
			-- default: .local/share/nvim/neotest-java/junit-platform-console-standalone-[version].jar
		}),
		require("neotest-dotnet")
	}
})


vim.keymap.set('n', '<leader>td', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>")
vim.keymap.set('n', '<leader>rt', "<cmd>lua require('neotest').run.run()<cr>")
vim.keymap.set('n', '<leader>dn', "<cmd>lua require('jdtls').test_nearest_method()<cr>")
