" ========================
" === PLUGIN SECTION ====
" ========================
call plug#begin('~/.local/share/nvim/plugged')

" LSP & Autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'onsails/lspkind-nvim'

" UI Enhancements
Plug 'NvChad/nvim-colorizer.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'

call plug#end()


" ========================
" === LUA CONFIG BLOCK ===
" ========================
lua << EOF
-- Safe require
local cmp_ok, cmp = pcall(require, "cmp")
local luasnip_ok, luasnip = pcall(require, "luasnip")
local lspkind_ok, lspkind = pcall(require, "lspkind")
local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
local capabilities_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if cmp_ok and luasnip_ok and lspkind_ok and lspconfig_ok and capabilities_ok then
  local capabilities = cmp_nvim_lsp.default_capabilities()

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" },
    }, {
      { name = "buffer" },
      { name = "path" },
    }),
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "...",
      }),
    },
  })

  -- Language Server setups
  -- Python
  lspconfig.pyright.setup {
    capabilities = capabilities
  }

  -- C/C++
  lspconfig.clangd.setup {
    capabilities = capabilities,
	cmd = { "clangd", "--fallback-style=Google", "--background-index", "--clang-tidy", "--header-insertion=never", "--completion-style=detailed", "--compile-commands-dir=." },
  }

  -- Lua (Optional)
  lspconfig.lua_ls.setup {
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        }
      }
    }
  }
end

-- Colorizer setup
local status_ok, colorizer = pcall(require, "colorizer")
if status_ok then
  colorizer.setup({
    user_default_options = {
      rgb_fn = true,
      hsl_fn = true,
      css = true,
    }
  })
end

-- Treesitter setup
local ts_status_ok, configs = pcall(require, "nvim-treesitter.configs")
if ts_status_ok then
  configs.setup {
    ensure_installed = { "c", "lua", "python", "javascript", "html", "css", "bash" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
end

-- Nvim-tree setup
local tree_ok, nvim_tree = pcall(require, "nvim-tree")
if tree_ok then
  nvim_tree.setup()
end
EOF

" ========================
" === UI & KEYBINDS ======
" ========================
" Color scheme and transparency tweaks
colorscheme default
hi Normal guibg=NONE
hi NormalNC guibg=NONE
hi EndOfBuffer guibg=NONE
hi LineNr guibg=NONE
hi SignColumn guibg=NONE

" Editor settings
set number
set tabstop=4
set shiftwidth=4
set clipboard=unnamedplus

" Keymaps
inoremap <C-BS> <C-w> 
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>e :NvimTreeFocus<CR>
nnoremap <leader>r :NvimTreeFindFile<CR>

