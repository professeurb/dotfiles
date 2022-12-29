local M

function M.setup()
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")

  telescope.setup {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    }
  }

  -- Enable telescope fzf native, if installed
  telescope.load_extension('fzf')

  -- which-key time
  -- local which_key_status_ok, which_key = pcall(require, "which-key")
  -- if not which_key_status_ok then
  --   return
  -- end
  --
  -- which_key.register({
  --   s = {
  --     name = "Search",
  --     l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
  --     q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
  --     r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
  --     s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
  --     S = {
  --       "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
  --       "Workspace Symbols",
  --     },
  --   },
  -- }, { prefix = "<leader>" })
  --
  -- See `:help telescope.builtin`
  vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
  vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer]' })

  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
end

return M
