syntax on
set number
set relativenumber
imap jj <Esc>

"nmap =j :%!python -c "import json, sys, collections; print json.dumps(json.load(sys.stdin, object_pairs_hook=collections.OrderedDict), indent=2)"
"nmap =x :%!xmllint --format %
"nmap =s :%s/[ ]*$//

set nocompatible

set laststatus=2            " always show statusbard
set noshowmode
set t_Co=256
set background=dark
"colorscheme desert
"colorscheme torte
colorscheme ron
set langmenu=en_CA.UTF-8
set encoding=utf-8
set mouse=a
set colorcolumn=80
set viminfo='100,<1000,s100,h

set expandtab
set showtabline=2
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set backspace=2
set backspace=indent,eol,start
set cursorline              " highlight cursor and column line
set cursorcolumn
set shortmess=atI           " hidden startup messages
set autowrite
set autoread
set confirm                 " what do with unsaved files

set incsearch
set hlsearch
set ignorecase
" mute search highlight with Ctrl-l
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l> 


" tabs setup
map tn :tabn<CR>
map tp :tabp<CR>
map tm :tabm
map tt :tabnew
map ts :tab split<CR>
map  <C-S-Right>      :tabn<CR>
imap <C-S-Right> <ESC>:tabn<CR>
map  <C-S-Left>       :tabp<CR>
imap <C-S-Left>  <ESC>:tabp<CR>

" navigate windows with meta+arrows
map  <M-Right>      <c-w>l
imap <M-Right> <ESC><c-w>l
map  <M-Left>       <c-w>h
imap <M-Left>  <ESC><c-w>h
map  <M-Up>         <c-w>k
imap <M-Up>    <ESC><c-w>k
map  <M-Down>       <c-w>j
imap <M-Down>  <ESC><c-w>j

" old autocompletion
imap <C-J> <C-X><C-O>
" uncomment to disable autocompletion preview
"set completeopt-=preview
set wildmenu
set wildmode=full
set complete=.,w,b,u,t,i

set scrolloff=3 " when scrolling keep cursor 3 lines away from bottom

"autocmd BufWinLeave *.* mkview
"autocmd BufWinEnter *.* silent loadview

" include ctag files for moving around code
set tags+=/home/adzik/Git/gitlab.cadc.pl/cic/monasca/monasca-persister/java/src/tags;/
set tags+=/home/adzik/Git/github.com/apache/kafka/tags;/

