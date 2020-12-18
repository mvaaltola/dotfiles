" show relative line numbers
set number relativenumber
set nu rnu

" ignore case except when typing capitals
set ignorecase
set smartcase

" treat _ as wordseparator
set iskeyword-=_

" search inrementally
set incsearch

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

" vimplug config
call plug#begin()

" make sure to use single quotes

" change surrounds (cs)
Plug 'https://github.com/tpope/vim-surround'

" add comments (gc)
Plug 'https://github.com/tpope/vim-commentary'

" add gitgutter
Plug 'https://github.com/airblade/vim-gitgutter'

" add vimwiki
Plug 'vimwiki/vimwiki'

" add markdown support
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" add easymotion for quick jumping
Plug 'easymootion/vim-easymotion'

" init plugin system
call plug#end()


