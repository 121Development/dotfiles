return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    local files = require('mini.files')
    files.setup({
  mappings = {
--//    go_out = '-',
  },
})
vim.keymap.set('n', '-', files.open)
  end,
}
