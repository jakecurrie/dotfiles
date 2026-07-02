local tmux_zoomed_by_zen = false

local function set_wezterm_zen(value)
  if vim.env.WEZTERM_PANE then
    vim.system({ "wezterm", "cli", "set-user-var", "ZEN_MODE", value }, { detach = true })
  end
end

local function set_tmux_zoom(enabled)
  if not vim.env.TMUX then
    return
  end

  if enabled then
    local result = vim.system({ "tmux", "display-message", "-p", "#{window_zoomed_flag}" }):wait()
    if result.code == 0 and vim.trim(result.stdout) == "0" then
      tmux_zoomed_by_zen = true
      vim.system({ "tmux", "resize-pane", "-Z" }, { detach = true })
    end
  elseif tmux_zoomed_by_zen then
    tmux_zoomed_by_zen = false
    vim.system({ "tmux", "resize-pane", "-Z" }, { detach = true })
  end
end

return {
  "folke/zen-mode.nvim",
  keys = {
    { "<leader>zm", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
  },
  opts = {
    window = {
      width = 1,
    },
    on_open = function()
      set_tmux_zoom(true)
      set_wezterm_zen("15")
    end,
    on_close = function()
      set_tmux_zoom(false)
      set_wezterm_zen("-1")
    end,
  },
}
