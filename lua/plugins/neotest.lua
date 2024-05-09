return {
  {
    'nvim-neotest/neotest',
    dependencies = { 'nvim-neotest/neotest-plenary', 'Issafalcon/neotest-dotnet', 'nvim-neotest/nvim-nio' },
    ft = { 'cs' },
    keys = {
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand '%')
        end,
        mode = 'n',
        desc = '[T]est [F]ile',
      },
      {
        '<leader>tn',
        function()
          require('neotest').run.run()
        end,
        mode = 'n',
        desc = '[T]est [N]earest',
      },
      {
        '<leader>ts',
        function()
          require('neotest').run.stop()
        end,
        mode = 'n',
        desc = '[T]est [S]top',
      },
      {
        '<leader>ta',
        function()
          require('neotest').run.attach()
        end,
        mode = 'n',
        desc = '[T]est [A]ttach',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run { strategy = 'dap' }
        end,
        mode = 'n',
        desc = '[T]est [D]ebug',
      },
    },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('neotest').setup {
        adapters = {
          require 'neotest-dotnet',
          require 'neotest-plenary',
          require 'neotest-dotnet' {
            dap = {
              args = { justMyCode = false },
              adapter_name = 'coreclr',
            },
            dotnet_additional_args = {
              '--verbosity detailed',
            },
            discovery_root = 'solution',
          },
        },
      }
    end,
  },
}
