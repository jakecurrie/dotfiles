return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
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
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
