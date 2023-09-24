local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
-- vim.keymap.set('n', '<leader>ps', function()
	-- Grep not working for some reason, even after checkhealth installs
	-- installing fd and ripgrep makes find_files not work anymore
	-- builtin.grep_string({ search = vim.fn.input("Grep > ") });
-- end)

require('telescope').setup({
    defaults = {
        layout_config = {
            width = 0.75,
            horizontal = { mirror = false },
            vertical = { mirror = false }
        }
    }
})
