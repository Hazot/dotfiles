local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	-- Grep not working for some reason, even after checkhealth installs
	-- installing fd and ripgrep makes find_files not work anymore
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

