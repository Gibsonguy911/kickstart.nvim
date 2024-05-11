return {
  'iabdelkareem/csharp.nvim',
  dependencies = {
    'Tastyep/structlog.nvim',
  },
  ft = { 'cs' },
  config = function()
    require('csharp').setup {
      lsp = {
        --enable = true,
        cmd_path = vim.fn.expand '$HOME/.local/share/nvim/mason/packages/omnisharp/omnisharp',
        dap = {
          adapter_name = 'coreclr',
        },
      },
    }
  end,
}
