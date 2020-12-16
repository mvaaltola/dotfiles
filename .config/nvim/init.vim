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

" vimplug config
call plug#begin()

" make sure to use single quotes

" change surrounds (cs)
Plug 'https://github.com/tpope/vim-surround'

" add comments (gc)
Plug 'https://github.com/tpope/vim-commentary'

" add gitgutter
Plug 'https://github.com/airblade/vim-gitgutter'

" init plugin system
call plug#end()


" vscode nvim specific setup
if exists('g:vscode')

" Workaround for gk/gj 
nnoremap gk :<C-u>call VSCodeCall('cursorMove', { 'to': 'up', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR> 
nnoremap gj :<C-u>call VSCodeCall('cursorMove', { 'to': 'down', 'by': 'wrappedLine', 'value': v:count ? v:count : 1 })<CR> 

endif


