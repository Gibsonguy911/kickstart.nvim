return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      {
        '<C-n>',
        ':Neotree focus filesystem left toggle<CR>',
        { noremap = true, silent = true },
      },
      {
        '<leader>r',
        ':NvimTreeRefresh<CR>',
        { noremap = true, silent = true },
      },
      {
        '<leader>n',
        ':NvimTreeFindFile<CR>',
        { noremap = true, silent = true },
      },
    },
  },
}
