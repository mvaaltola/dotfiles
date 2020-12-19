" show relative line numbers
set number relativenumber
set nu rnu

" leave space around cursor
set scrolloff=5

" ignore case except when typing capitals
set ignorecase
set smartcase

" set leader to space
let mapleader = "\<Space>"

" show ruler at 120chars
set cc=120

" treat _ as wordseparator
set iskeyword-=_

" search inrementally
set incsearch

" update gitgutter faster
set updatetime=100

" fold by indent
set foldmethod=indent

" markdown folding
filetype plugin indent on
set foldenable
let g:vim_markdown_folding_disabled = 1
let g:vimwiki_folding = 'expr'

" show existing tabs with 4 spaces
set tabstop=4

" indent 4 spaces with >
set shiftwidth=4

" insert 4 spaces on tab
set expandtab

" vimwiki config
let g:vimwiki_list = [{'path': '~/mikael@vaalto.la/notes/vimwiki/',
    \ 'syntax': 'markdown', 'ext': '.md'}]

" show quick-scope only on keypress
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" remaps
" quickly scroll up/down
nnoremap J 7j
nnoremap K 7k
vnoremap J 7j
vnoremap K 7k

" quickly scroll left/right
nnoremap H b
nnoremap L w

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

" add markdown support
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" quick-scope for easier f/t navigation
Plug 'unblevable/quick-scope'

" init plugin system
call plug#end()

" disable gitgutter background color
highlight! link SignColumn LineNr

