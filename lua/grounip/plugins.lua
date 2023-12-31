local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- Plugins
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins

	use("windwp/nvim-autopairs") -- Autopairs, automatticallly close () [] {}
	use("windwp/nvim-ts-autotag") -- Autotags, <></>
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("github/copilot.vim")
	use("nvim-lualine/lualine.nvim") -- Statusline
	use("folke/which-key.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use({ "christoomey/vim-tmux-navigator", lazy = false })
	use({ "mg979/vim-visual-multi", branch = "master" })
	use({
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup()
		end,
	})

	use({
		"kkoomen/vim-doge",
		run = ":call doge#install()",
	})

	use("nvim-tree/nvim-tree.lua") -- Explorer
	use("nvim-tree/nvim-web-devicons")

	-- color highlight
	use("norcalli/nvim-colorizer.lua")

	-- Bufferline
	use("akinsho/bufferline.nvim")
	use("moll/vim-bbye")

	-- Terminal
	use("akinsho/toggleterm.nvim")

	-- Colorschemes
	use("lunarvim/darkplus.nvim")
	use({
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	})

	-- Cmp
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- Snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP

	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/mason.nvim") -- simple to use language server installer
	use("williamboman/mason-lspconfig.nvim")
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "c0c19f32b614b3921e17886c541c13a72748d450" })
	use("RRethy/vim-illuminate")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

	-- Treesitter
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- GO
	use("mfussenegger/nvim-dap")

	use({
		"dreamsofcode-io/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
		end,
	}) -- dap for go

	use({
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	}) -- go tools

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
