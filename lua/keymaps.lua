vim.cmd("set noexpandtab")
vim.cmd("set shiftwidth=2")
vim.cmd("set softtabstop=2")
vim.cmd("set tabstop=2")
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.foldmethod = "manual"
vim.g.mapleader = " "
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>tn", function()
	vim.cmd("set number!")
end, { desc = "Toggle line [n]umbering" })

vim.keymap.set("n", "<leader>tr", function()
	vim.cmd("set relativenumber!")
end, { desc = "Toggle [r]elative line numbering" })

--#region autocmd for saving and loadin line folds
local rememberFoldsAugroup = vim.api.nvim_create_augroup("remember_folds", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = rememberFoldsAugroup,
	callback = function()
		vim.cmd("silent! loadview")
	end,
})
vim.api.nvim_create_autocmd("BufWinLeave", {
	group = rememberFoldsAugroup,
	callback = function()
		vim.cmd("silent! mkview")
	end,
})

-- see https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua for more helpful configurations and keymaps
-- all configurations and keymaps below this line are from kickstart.nvim template

-- Disable arrow keys in normal mode (to improve vim usage)
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
