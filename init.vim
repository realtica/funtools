call plug#begin('~/.vim/plugged')
" Status Bar
Plug 'glepnir/galaxyline.nvim'
" Tabbar
Plug 'romgrk/barbar.nvim'
" Telescope fuzzy files and preview
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
" Telescope
Plug 'nvim-telescope/telescope-project.nvim'
" Parentheses, brakets, etc
Plug 'p00f/nvim-ts-rainbow'
" Autoclose HTML tags
Plug 'windwp/nvim-ts-autotag'
" navigate and highlight matching words
Plug 'andymass/vim-matchup'
" Fast as FUCK nvim completion. SQLite, concurrent scheduler, hundreds of hours of optimization. 
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
" 9000+ Snippets
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
" Plug 'williamboman/nvim-lsp-installer'
"
Plug 'ray-x/guihua.lua', {'do': 'cd lua/fzy && make' }
Plug 'ray-x/navigator.lua'
Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'neovim/nvim-lspconfig'
" Themes
Plug 'lifepillar/vim-solarized8'
Plug 'arcticicestudio/nord-vim'
Plug 'EdenEast/nightfox.nvim'

Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'sbdchd/neoformat'

Plug 'kyazdani42/nvim-web-devicons' " lua
Plug 'yamatsum/nvim-nonicons'
Plug 'https://github.com/adelarsq/vim-devicons-emoji'
Plug 'https://github.com/terrortylor/nvim-comment'
call plug#end()
set mouse=a
filetype plugin indent on
" let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
set clipboard=unnamedplus
" Exit Insert mode
inoremap jk <ESC>
" inoremap ss <ESC>:w<CR>i
nnoremap ss :w<CR>
nnoremap <space><space> <cmd>Telescope find_files<cr>
nnoremap <space>r <cmd>Telescope oldfiles<cr>
nnoremap <silent> ff    <cmd>lua vim.lsp.buf.formatting()<CR>
set background=dark

" colorscheme solarized8_high
" colorscheme nord
colorscheme nightfox
" Enable true color
set termguicolors

set relativenumber

set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
" set autoindent
" set smartindent
" always uses spaces instead of tab characters
set expandtab
syntax enable
set cc=80
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

let g:python3_host_prog=$HOME.'/.pyenv/shims/python'
" custom setting for clangformat
let g:neoformat_c_clangformat = {
    \ 'exe': 'clang-format',
    \ 'args': ['--style="{BasedOnStyle: Mozilla, IndentWidth: 4}"', '--verbose']
\}
let g:neoformat_enabled_c = ['clangformat']

" let g:neoformat_html_prettier = {
"               \ 'exe': 'prettier',
"               \ 'args': ['--stdin', '--single-quote'],
"               \ 'stdin': 1,
"               \ }
" let g:neoformat_enabled_html = ['prettier']
" 
" let g:neoformat_run_all_formatters = 1
let g:neoformat_python_black = {
    \ 'exe': 'python -m black',
    \ 'stdin': 1,
    \ 'args': ['-q', '-'],
    \ }
let g:neoformat_enabled_python = ['black']
let g:shfmt_opt="-ci"
" let g:neoformat_sh = {
"     \ 'exe': 'shfmt',
"     \ 'args': ['-i 2', '-ci']
" \}
" let g:neoformat_enabled_sh = ['shfmt']
" let g:neoformat_verbose = 1
let g:neoformat_only_msg_on_error = 1
let g:coq_settings = { 'auto_start': v:true }
" LUA
lua << EOF
require'navigator'.setup(
{
  lsp={
      format_on_save=false
    }
}
)
local coq = require "coq"
require'lspconfig'.clangd.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.html.setup(
coq.lsp_ensure_capabilities()
)
require'lspconfig'.pylsp.setup{}
require'lspconfig'.rust_analyzer.setup{}
-- require'lspconfig'.eslint.setup{}
require("trouble").setup {}
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
require("nvim-treesitter.configs").setup {
  ensure_installed={
    "html",
    "typescript",
    "c",
    "php",
    "bash",
    "javascript",
    "python",
    "rust"
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
  autotag = {
    enable = true,
  }
}
require'telescope'.load_extension('project')
vim.api.nvim_set_keymap(
    'n',
    '<C-p>',
    ":lua require'telescope'.extensions.project.project{}<CR>",
    {noremap = true, silent = true}
)

-- barbar --
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', ':BufferPrevious<CR>', opts)
map('n', '<A-.>', ':BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', ':BufferMovePrevious<CR>', opts)
map('n', '<A->>', ' :BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', ':BufferGoto 1<CR>', opts)
map('n', '<A-2>', ':BufferGoto 2<CR>', opts)
map('n', '<A-3>', ':BufferGoto 3<CR>', opts)
map('n', '<A-4>', ':BufferGoto 4<CR>', opts)
map('n', '<A-5>', ':BufferGoto 5<CR>', opts)
map('n', '<A-6>', ':BufferGoto 6<CR>', opts)
map('n', '<A-7>', ':BufferGoto 7<CR>', opts)
map('n', '<A-8>', ':BufferGoto 8<CR>', opts)
map('n', '<A-9>', ':BufferGoto 9<CR>', opts)
map('n', '<A-0>', ':BufferLast<CR>', opts)
-- Close buffer
map('n', '<A-c>', ':BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout<CR>
-- Close commands
--                 :BufferCloseAllButCurrent<CR>
--                 :BufferCloseBuffersLeft<CR>
--                 :BufferCloseBuffersRight<CR>
-- Magic buffer-picking mode
map('n', '<C-s>', ':BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<Space>bb', ':BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bd', ':BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', ':BufferOrderByLanguage<CR>', opts)
EOF
lua require("bubbles")
lua require('nvim_comment').setup()
