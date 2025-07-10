-- [[ plug.lua ]]

return require('packer').startup(function(use)
    -- [[ Plugins Go Here ]]

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    -- [[ Theme ]]
    use { 'mhinz/vim-startify' }
    use { 'DanilaMihailov/beacon.nvim' }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
	use { 'catppuccin/nvim', as = 'catppuccin' }

    -- [[ Dev ]]
    use { -- telescope - find files
        'nvim-telescope/telescope.nvim',
		requires = {
			{'nvim-lua/plenary.nvim'},
			{'nvim-telescope/telescope-live-grep-args.nvim'}
		}
	}
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make'
    }

    use 'majutsushi/tagbar' -- code structure
    use 'Yggdroot/indentLine' -- see indentation
    use 'tpope/vim-fugitive' -- git integration
    use 'junegunn/gv.vim' -- commit history
    use 'windwp/nvim-autopairs' -- auto close parenthesis
    use 'williamboman/nvim-lsp-installer' -- auto install language server
    use 'neovim/nvim-lspconfig' -- Nvim LSP
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
    use 'numToStr/Comment.nvim' -- Comment keyboard shortcut
    use 'wakatime/vim-wakatime' -- Wakatime API Integration
    use 'APZelos/blamer.nvim' -- Inline blame like GitLens
    use 'gpanders/editorconfig.nvim' -- Editorconfig for nvim
    use {
        'ThePrimeagen/harpoon',
        requires = 'nvim-lua/plenary.nvim'
    } -- switch between main files
	
	use 'christoomey/vim-tmux-navigator'

	use 'othree/html5.vim'
	use 'pangloss/vim-javascript'
	use { 'evanleck/vim-svelte', branch = 'main'}

	use 'jose-elias-alvarez/null-ls.nvim'
	use 'MunifTanjim/prettier.nvim'

end)
