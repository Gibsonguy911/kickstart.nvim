return {
  'iabdelkareem/csharp.nvim',
  dependencies = {
    'Tastyep/structlog.nvim',
  },
  config = function()
    local map = function(keys, func, buf, desc)
      vim.keymap.set('n', keys, func, { buffer = buf, desc = 'LSP: ' .. desc })
    end

    local get_namespace = function(type)
      local current = vim.fn.expand '%:p'
      local dir = vim.fn.fnamemodify(current, ':h')
      local project_dir = vim.fn.getcwd()
      local csproj_dir = nil

      while dir ~= project_dir do
        local files = vim.fn.systemlist(string.format('rg --type-add csproj:*.csproj --files --type csproj --max-depth 1 %s', dir))
        if #files > 0 then
          csproj_dir = dir
          break
        end
        dir = vim.fn.fnamemodify(dir, ':h')
      end

      if csproj_dir == nil then
        print 'no .csproj found'
        return
      end

      local n = vim.fn.fnamemodify(csproj_dir, ':t') .. current:sub(#csproj_dir + 1)
      n = vim.fn.fnamemodify(n, ':h')
      n = n:gsub('[/\\]', '.')

      local className = vim.fn.fnamemodify(vim.fn.expand '%:t', ':r')
      local class = ''
      if type:find('interface', 1, true) then
        class = 'public ' .. type .. ' I' .. className
      else
        class = 'public ' .. type .. ' ' .. className
      end
      vim.api.nvim_buf_set_lines(0, 0, 1, false, { 'namespace ' .. n .. ';', '', class, '{', '', '}' })

      -- Move cursor to the class body
      vim.api.nvim_win_set_cursor(0, { 5, 0 })
      -- save current file
      vim.cmd 'w'
    end

    require('csharp').setup {
      lsp = {
        --enable = true,
        cmd_path = vim.fn.expand '$HOME/.local/share/nvim/mason/packages/omnisharp/omnisharp',
        on_attach = function(_, buf)
          map('gd', require('csharp').go_to_definition, buf, '[CS]: [G]oto [D]efinition')

          -- template keymaps
          map('<leader>tc', function()
            get_namespace 'class'
          end, buf, '[T]emplate [C]lass')
          map('<leader>ti', function()
            get_namespace 'interface'
          end, buf, '[T]emplate [I]nterface')
          map('<leader>te', function()
            get_namespace 'enum'
          end, buf, '[T]emplate [E]num')
        end,
        dap = {
          adapter_name = 'coreclr',
        },
      },
    }
  end,
}
