-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.transparent_window = true
lvim.colorscheme = "darkplus"

lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "sbdchd/neoformat" },
  { "neoclide/coc.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "prettier/vim-prettier" },
  {
    "vyfor/cord.nvim",
    build = './build',
    event = 'VeryLazy',
    opts = {
      editor = {
        client = 'lunarvim', -- vim, neovim, lunarvim, nvchad, astronvim or your application's client id
      },
      text = {
        file_browser = 'Browsing files in {}',     -- Text to display when browsing files (Empty string to disable)
        plugin_manager = 'Managing plugins in {}', -- Text to display when managing plugins (Empty string to disable)
        lsp_manager = 'Configuring LSP in {}',     -- Text to display when managing LSP servers (Empty string to disable)
        vcs = 'Committing changes in {}',          -- Text to display when using Git or Git-related plugin (Empty string to disable)
        workspace = 'Workspace: {}',               -- Text to display when in a workspace (Empty string to disable)
      }
    },
  },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      'nvimtools/hydra.nvim',
    },
    opts = {},
    cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
    keys = {
      {
        mode = { 'v', 'n' },
        '<Leader>m',
        '<cmd>MCstart<cr>',
        desc = 'Create a selection for selected text or word under the cursor',
      },
    },
  },
}

-- Neoformat configuration
vim.cmd([[
  augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
  augroup END
]])

-- VIM RELATED --

lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  f = { "<cmd>ToggleTerm<cr>", "Floating terminal" },
  v = { "<cmd>2ToggleTerm size=30 direction=vertical<cr>", "Split vertical" },
  h = { "<cmd>2ToggleTerm size=30 direction=horizontal<cr>", "Split horizontal" },
}

-- EVERYTHING C RELATED --

-- Add C CompileAndRun command
vim.cmd("command! CCompile :w | !gcc -o %< %")
vim.cmd("command! CRun :w | !gcc -o %< % && ./%<")

-- Neoformat configuration for C
vim.g.neoformat_enabled_c = { "clangformat" }

-- Function to switch between .c and .h files
function switch_c_h()
  local filename = vim.fn.expand('%')
  if filename:match('%.c$') then
    vim.cmd('edit ' .. filename:gsub('%.c$', '.h'))
  elseif filename:match('%.h$') then
    vim.cmd('edit ' .. filename:gsub('%.h$', '.c'))
  else
    print('This file is neither a .c file nor a .h file')
  end
end

-- Set a normal mode mapping for <leader>h
lvim.keys.normal_mode["<S-x>"] = ":lua switch_c_h()<CR>"

-- EVERYTHING PYTHON RELATED --

-- Example LSP configuration using `nvim-lspconfig`
local lspconfig = require 'lspconfig'
lspconfig.pyright.setup {}

-- formatting
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*" }

-- Add save n run command
vim.api.nvim_create_user_command(
  'PyRun',
  function(opts)
    -- Save the current buffer
    vim.cmd('write')
    -- Build the command with the provided arguments
    local command = 'python3 ' .. vim.fn.expand('%') .. ' ' .. opts.args
    -- Execute the command in the terminal
    vim.cmd('terminal ' .. command)
  end,
  { nargs = '*' }
)
