" show relative line numbers
set number relativenumber

" leave space around cursor
set scrolloff=5

" ignore case except when typing capitals
set ignorecase
set smartcase

" search inrementally
set incsearch

" set leader to space
let mapleader = "\<Space>"

" show ruler at 120chars
set cc=120

" treat _ as wordseparator
" set iskeyword-=_

" update gitgutter faster
set updatetime=100

" statusline
set statusline=
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

" fold by indent
set foldmethod=indent

" markdown wrapping and autoformatting
augroup markdown
    autocmd!
    autocmd FileType markdown set cc=0
    autocmd FileType rmarkdown set cc=0
augroup END
" vim-pandoc: hard wraps at col 119 with auto-formatting
" let g:pandoc#formatting#mode = 'hA'
" let g:pandoc#formatting#textwidth = '119'

" markdown folding
filetype plugin indent on
set foldenable
let g:vimwiki_folding = 'expr'

" disable spell checking, fold column
set nospell
let g:pandoc#modules#disabled = [ "spell" ]
let g:pandoc#folding#fdc = 0

" show existing tabs with 4 spaces
set tabstop=4

" indent 4 spaces with >
set shiftwidth=4

" insert 4 spaces on tab
set expandtab

" vimwiki config
let g:vimwiki_list = [{'path': '~/mikael@vaalto.la/notes/vimwiki/',
    \ 'syntax': 'markdown', 'ext': '.md'}]

" quickscope plugin settings
" show quick-scope only on keypress
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" quickscope colors
augroup qs_colors
    autocmd!
    autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
    autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

" global search and replace by default
" set gdefault

" remaps

" tab goes to matching bracket

nnoremap <tab> %
vnoremap <tab> %

" vimplug config

call plug#begin()

" make sure to use single quotes

" change surrounds (cs)
Plug 'tpope/vim-surround'

" add comments (gc)
Plug 'tpope/vim-commentary'

" add gitgutter
Plug 'airblade/vim-gitgutter'

" add vimwiki
Plug 'vimwiki/vimwiki'

" quick-scope for easier f/t navigation
Plug 'unblevable/quick-scope'

" color schemes
Plug 'rafi/awesome-vim-colorschemes'
Plug 'dylanaraps/wal.vim'

" pandoc, rmarkdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'

" LaTeX
Plug 'lervag/vimtex'

" init plugin system
call plug#end()

" set colorscheme
" set termguicolors
" colorscheme PaperColor
colorscheme wal

" disable gitgutter background color
highlight! link SignColumn LineNr

