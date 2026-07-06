return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, '.')
      end,
      is_always_hidden = function(name, bufnr)
        return false
      end,
    },
  },
  keys = {
    {
      "-",
      function()
        require("oil").open()
      end,
      desc = "Open Oil",
    },
    {
      "<leader>-",
      function()
        local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
        if vim.v.shell_error ~= 0 then
          root = vim.fn.getcwd()
        end
        require("oil").open(root)
      end,
      desc = "Open Oil at git root",
    },
  },
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  lazy = false,
}
