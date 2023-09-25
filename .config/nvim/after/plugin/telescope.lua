local telescope = require("telescope")
local telescopeConfig = require("telescope.config")

-- Clone the default Telescope configuration
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- I want to search in hidden/dot files.
table.insert(vimgrep_arguments, "--hidden")
-- I don't want to search in the `.git` directory.
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

telescope.setup({
    defaults = {
        -- `hidden = true` is not supported in text grep commands.
        hidden = true,
        vimgrep_arguments = vimgrep_arguments,
    },
    pickers = {
        find_files = {
            hidden = true,
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = {
                "fd",
                "--hidden",
                "--exclude",
                ".git"
            },
        },
    },
})

----- This activates the search for hidden files in live_grep
require("telescope").setup {
    pickers = {
        live_grep = {
            additional_args = function(_ts)
                return { "--hidden" }
            end
        },
    },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    -- Grep not working for some reason, even after checkhealth installs
    -- installing fd and ripgrep makes find_files not work anymore
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
