" === General Settings ===
syntax enable
set encoding=utf8
set ffs=unix,dos,mac
set history=500
set so=7             " Scroll offset
set cmdheight=1
set ruler
set wildmenu
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
set background=dark
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set foldcolumn=1

" === Colors ===
try
    colorscheme desert
catch
endtry
if $COLORTERM == 'gnome-terminal' || has("gui_running")
    set t_Co=256
endif
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set guitablabel=%M\ %t
endif

" === File Behavior ===
set nobackup
set nowb
set noswapfile
set hidden

" === Tabs & Indentation ===
set expandtab
set shiftwidth=4
set tabstop=4
set smarttab
set ai
set si

" === Text Editing ===
set lbr
set tw=500
set wrap
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set showmatch
set mat=2
set magic
set lazyredraw

" === Search ===
set ignorecase
set smartcase
set hlsearch
set incsearch

" === Key Bindings ===
inoremap jk <ESC>
nmap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Window navigation
nmap <C-j> <C-W>j
nmap <C-k> <C-W>k
nmap <C-h> <C-W>h
nmap <C-l> <C-W>l

" Tab management
nmap <Leader>tn :tabnew<CR>
nmap <Leader>to :tabonly<CR>
nmap <Leader>tc :tabclose<CR>
nmap <Leader>tm :tabmove 
nmap <Leader>t<Leader> :tabnext<CR>
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Buffer management
nmap <Leader>bd :Bclose<cr>:tabclose<cr>gT
nmap <Leader>ba :bufdo bd<cr>
nmap <Leader>l :bnext<cr>
nmap <Leader>h :bprevious<cr>
nmap <Leader>cd :cd %:p:h<cr>:pwd<cr>
nmap <Leader>te :tabedit <C-r>=expand("%:p:h")<CR>/

" Quick scratch files
nmap <Leader>q :e ~/buffer<cr>
nmap <Leader>x :e ~/buffer.md<cr>

" Toggle paste mode
nmap <Leader>pp :setlocal paste!<CR>

" Spell check
nmap <Leader>ss :setlocal spell!<CR>
nmap <Leader>sn ]s
nmap <Leader>sp [s
nmap <Leader>sa zg
nmap <Leader>s? z=

" Disable highlight on <Leader><CR>
nmap <silent> <Leader><CR> :noh<CR>

" Remap 0 to first non-blank
nmap 0 ^

" ALT/Command Line Movement
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Visual selection search
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Restore cursor position on file reopen
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Delete trailing whitespace on save
function! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()

" === Custom Functions ===
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")
    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif
    if bufnr("%") == l:currentBufNum
        new
    endif
    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"
    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")
    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif
    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

