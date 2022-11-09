-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Lazy loading:
  -- Load on specific commands
  use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}

  -- Load on an autocommand event
  use {'andymass/vim-matchup', event = 'VimEnter'}

  -- Load on a combination of conditions: specific filetypes or commands
  -- Also run code after load (see the "config" key)
  use {
    'w0rp/ale',
    ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
    cmd = 'ALEEnable',
    config = 'vim.cmd[[ALEEnable]]'
  }

  -- Plugins can have dependencies on other plugins
  use {
    'haorenW1025/completion-nvim',
    opt = true,
    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  }

  -- You can specify rocks in isolation
  use_rocks 'penlight'
  use_rocks {'lua-resty-http', 'lpeg'}

  -- Local plugins can be included
  -- use '~/projects/personal/hover.nvim'

  -- Plugins can have post-install/update hooks
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- Post-install/update hook with neovim command
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Post-install/update hook with call of vimscript function with argument
  use { 'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

  -- Use dependency and run lua function after load
  use {
    'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('gitsigns').setup() end
  }

  -- You can alias plugin names
  use {'dracula/vim', as = 'dracula'}
	use {'jparise/vim-graphql'}


  use {
  	'nvim-lualine/lualine.nvim',
  	requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

	use('neovim/nvim-lspconfig')
	use('jose-elias-alvarez/null-ls.nvim')
	use('MunifTanjim/prettier.nvim')

	-- 補完エンジン本体
  use "hrsh7th/nvim-cmp" 
	----LSPを補完ソースに
  use 'hrsh7th/cmp-nvim-lsp' 
	----bufferを補完ソースに
  -- use 'hrsh7th/cmp-buffer'　
	----pathを補完ソースに
  use 'hrsh7th/cmp-path'  
	------スニペットエンジン
  use 'hrsh7th/vim-vsnip' 
	----スニペットを補完ソースに
  use 'hrsh7th/cmp-vsnip' 
	----補完欄にアイコンを表示
  use 'onsails/lspkind.nvim' 

   use "L3MON4D3/LuaSnip"
  use 'hrsh7th/cmp-cmdline' 

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.0',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

-- ファイラー
use { "nvim-telescope/telescope-file-browser.nvim" }

use {
	"windwp/nvim-ts-autotag",
    config = function() require("nvim-ts-autotag").setup {} end
}

use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
}

-- 前回良かったテーマ
use {
	"EdenEast/nightfox.nvim",
	config = function()
		vim.cmd('colorscheme terafox')	
	end
}


-- LSP
use { "williamboman/mason.nvim" }
use { "williamboman/mason-lspconfig.nvim" }

-- Tab 
use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'kyazdani42/nvim-web-devicons',
		config = function()
			vim.otp.termguicolors = true
			local line =  require("bufferline")
			line.setup{}
		end
}


-- Hovering Documentation
use({
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        local saga = require("lspsaga")

        saga.init_lsp_saga({
            -- your configuration
						typescript = 'typescript'
        })

				local opts = { noremap = true, silent = true } 
				vim.keymap .set('n', '<C-n>>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts) 
				vim.keymap.set('n', '<C-h>', '<Cmd>Lspsaga hover_doc<CR>' , opts) 
				vim.keymap.set('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts) 
				vim.keymap.set('i', '<C-k>', '<Cmd> Lspsaga signature_help<CR>', opts) 
				vim.keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts) 
				vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
    end,
})


-- 外部コマンドを使用してコードをフォーマット
use("acro5piano/nvim-format-buffer")

use "brenoprata10/nvim-highlight-colors"


-- 消さない
end)
