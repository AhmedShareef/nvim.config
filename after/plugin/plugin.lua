-- PLUGIN CONFIG

--[[ 'nvim-tree' ]] 
require('nvim-tree').setup({
    sort_by = "case_sensitive",
    view = {
        -- adaptive_size = true,
    }, renderer = { 
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "all",
        indent_markers = {
            enable = true,
        },
    },
    filters = { 
		custom = {'.git'},
		dotfiles = true, 
		git_ignored = false,
		exclude = { '.gitignore', '.env' },
	},
    update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
    },
})

-- [[ lualine ]]
require('lualine').setup {
    options = {
        theme = 'dracula'
    }
}

-- [[ nvim-autopairs ]]
require('nvim-autopairs').setup {}

-- [[ lsp ]]
require('nvim-lsp-installer').setup { automatic_installation = true }

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require('lspconfig')

local on_attach = function(client, bufnr)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to Definition" })
end

-- Enable servers with the additional capabilities
local servers = { 'emmet_ls', 'pyright', 'tsserver', 'eslint', 'tailwindcss', 'svelte', 'gopls', 'rust_analyzer' }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup { capabilities = capabilities, on_attach = on_attach }
end

lspconfig.svelte.setup {
  filetypes = { "svelte" },
  on_attach = function(client, bufnr)
    if client.name == 'svelte' then
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.ts", "*.svelte" },
        callback = function(ctx)
          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
        end,
      })
    end
    if vim.bo[bufnr].filetype == "svelte" then
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = { "*.js", "*.ts", "*.svelte" },
        callback = function(ctx)
          client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
        end,
      })
    end
  end
}

-- luasnip
local luasnip = require 'luasnip'

-- nvim-cmp
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}

-- lsp lines
require('lsp_lines').setup {
    vim.diagnostic.config({ virtual_lines = false })
}

-- todo comments
-- require('todo-comments').setup {}

-- comment
require('Comment').setup {}

-- telescope fzf
require('telescope').setup {}
require('telescope').load_extension('fzf')

-- catppuccin
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
require("catppuccin").setup()
vim.cmd [[colorscheme catppuccin]]

local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>F", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>v", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

local prettier = require('prettier')
prettier.setup()
