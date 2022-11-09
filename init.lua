require('plugins')



local custom_gruvbox = require'lualine.themes.gruvbox'
require('lualine').setup {
  options = { theme  = custom_gruvbox },
  ...
}


-- Vim Config
vim.g.mapleader = " "
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.wrap = false
vim.o.signcolumn = "yes"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.number = true
vim.o.autoindent = true
vim.o.hlsearch = true
vim.o.clipboard = "unnamed"
vim.o.background = true
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {silent=true})
vim.o.termguicolors = true




-- LSP
local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

local on_attach = function(client, bufnr)
  -- format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("Format", { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end

-- TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}

local status, cmp = pcall(require, "cmp")
if (not status) then return end
local lspkind = require 'lspkind'

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
  }
})

vim.cmd [[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]]

-- telescope (Finder)
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- ファイルを開いた時に、カーソルの場所を復元する
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})

require'lspconfig'.tailwindcss.setup{}

-- 特定の言語に対してLSPのサポート
local status, mason = pcall(require, "mason") 
if (not status) then return end 
local status2, lspconfig = pcall(require, "mason-lspconfig") 
if (not status2) then return end 

mason.setup({} ) 

lspconfig.setup { 
  ensure_installed = { "sumneko_lua", "tailwindcss" }, 
}

-- null_ls and prettier
local null_ls = require "null-ls"
null_ls.setup {
  sources = {
    null_ls.builtins.formatting.deno_fmt.with {
      condition = function(utils)
        return not (utils.has_file { ".prettierrc", ".prettierrc.js", "deno.json", "deno.jsonc" })
      end,
    },
    null_ls.builtins.formatting.prettier.with {
      condition = function(utils)
        return utils.has_file { ".prettierrc", ".prettierrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
  },
}
