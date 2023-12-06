require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

vim.keymap.set('n', '<F9>', '<cmd>lua require("dap").toggle_breakpoint()<cr>')
vim.keymap.set('n', '<F5>', '<cmd>lua require("dap").continue()<cr>')
vim.keymap.set('n', '<F10>', '<cmd>lua require("dap").step_over()<cr>')
vim.keymap.set('n', '<F11>', '<cmd>lua require("dap").step_into()<cr>')