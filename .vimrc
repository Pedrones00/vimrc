"==========================================
" BASIC SETTINGS
" ==========================================
set number              " Show line numbers
set relativenumber      " Show relative line numbers
set tabstop=4           " Use four spaces for tabs
set shiftwidth=4        " Set the auto-indent size
set expandtab           " Convert tabs to spaces
set autoindent
set smartindent
set ignorecase          " Make searches case-insensitive
set smartcase           " Use case-sensitive search when you type uppercase letters
set nowrap              " Do not wrap lines
set scrolloff=8         " Keep eight lines visible above and below the cursor
set incsearch           " Show search results while typing
set hlsearch            " Highlight search results
set mouse=a             " Enable mouse support
syntax on
let mapleader = " "     " Set the leader key to <Space>

" ==========================================
" File Explorer (Netrw)
" ==========================================
let g:netrw_banner = 0         " Hide the banner
let g:netrw_winsize = 25       " Set the default width to 25%
let g:netrw_browse_split = 4   " Open new windows on the right
let g:netrw_altv = 1           " Force vertical splits to the right
let g:netrw_keepdir = 0        " Keep the current directory synchronized
let g:netrw_liststyle = 3      " Tree style


" ==========================================
" Keybinds
" ==========================================

" Open the file tree
nnoremap <silent> <leader>e :Lexplore<CR> 

" Save the file
nnoremap <silent> <leader>w :w<CR>

" Quit Vim
nnoremap <silent> <leader>q :q<CR>

" Move between windows
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" Equalize window sizes
nnoremap <leader>= <C-w>=

" Set the current window width to 50 columns
nnoremap <leader>r :vertical resize 50<CR>

" Toggle line wrapping
nnoremap <leader>z :set wrap!<CR>

" Open a terminal at the bottom
nnoremap <leader>t :botright terminal<CR>

" Resize windows with Ctrl + Arrow keys
nnoremap <C-Up> :resize +2<CR>
nnoremap <C-Down> :resize -2<CR>
nnoremap <C-Left> :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" ==========================================
" File search
" ==========================================
set path+=**           " Search recursively
set wildmenu           " Show the command-line completion menu
set wildmode=longest,list,full
set wildignore+=*/.git/*,*/target/*,*/node_modules/*,*/build/* " Ignore these paths

function! FindFile() abort
    let l:name = input('Find file: ')

    if empty(l:name)
        return
    endif

    if !executable('rg')
        echoerr 'ripgrep (rg) is required for file search'
        return
    endif

    let l:root = getcwd()
    let l:pattern = '*' . escape(l:name, '*?[]') . '*'
    let l:command = 'rg --files --hidden --no-messages --iglob ' . shellescape(l:pattern)
        \ . ' --glob ' . shellescape('!.git/**')
        \ . ' ' . shellescape(l:root)
    let l:files = systemlist(l:command)

    if empty(l:files)
        echo 'No files found in ' . l:root
        return
    endif

    let l:target_win = win_getid()
    botright new
    resize 10
    let b:findfile_target_win = l:target_win

    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal nobuflisted
    setlocal cursorline
    setlocal nowrap
    setlocal modifiable

    call setline(1, ['Files found in: ' . l:root, ''])
    call append(2, l:files)

    setlocal nomodifiable
    normal! gg

    nnoremap <silent> <buffer> <CR> :call SelectFoundFile()<CR>
    nnoremap <silent> <buffer> q :close<CR>
endfunction

function! SelectFoundFile() abort
    if line('.') <= 2
        return
    endif

    let l:file = getline('.')
    let l:target_win = get(b:, 'findfile_target_win', 0)
    close

    if l:target_win > 0
        call win_gotoid(l:target_win)
    endif

    execute 'edit ' . fnameescape(l:file)
endfunction

nnoremap <silent> <C-p> :call FindFile()<CR>

" ==========================================
" Words search
" ==========================================
" Search recursively across the project
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case\ --fixed-strings\ --no-messages
    set grepformat=%f:%l:%c:%m

    function! SearchProject() abort
        let l:term = input('Search project: ')

        if empty(l:term)
            return
        endif

        " Keep Netrw in its own window
        if &filetype ==# 'netrw'
            wincmd p
        endif

        execute 'silent! grep! ' . shellescape(l:term)
        botright copen
        redraw!
    endfunction

    nnoremap <silent> <leader>f :call SearchProject()<CR>
endif

" ==========================================
" GIT
" ==========================================
" Show the current Git branch
let g:git_branch = ''

function! UpdateGitBranch() abort
    let l:file_dir = expand('%:p:h')

    if empty(l:file_dir)
        let l:file_dir = getcwd()
    endif

    let l:branch = system(
        \ 'git -C ' . shellescape(l:file_dir) .
        \ ' branch --show-current 2>/dev/null'
        \ )

    let g:git_branch = substitute(l:branch, '\n\+$', '', '')

    if !empty(g:git_branch)
        let g:git_branch = 'branch: ' . g:git_branch
    endif

    redrawstatus
endfunction


augroup git_statusline
    autocmd!
    autocmd BufEnter * call UpdateGitBranch()
    autocmd DirChanged * call UpdateGitBranch()
augroup END

set laststatus=2
set statusline=%f\ %h%m%r%=%{g:git_branch}\ \ %l:%c


" ==========================================
" REPLACE
" ==========================================

function! ReplaceText() abort
    let l:old = input('Replace: ')

    if empty(l:old)
        return
    endif

    let l:new = input('With: ')

    execute '%s/' . escape(l:old, '/\') . '/' . escape(l:new, '/\') . '/gc'
endfunction

nnoremap <silent> <leader>R :call ReplaceText()<CR>

" ==========================================
" CREATE FILE
" ==========================================
function! NewFile() abort
    let l:name = input('New file: ')

    if empty(l:name)
        return
    endif

    let l:root = getcwd()

    if &filetype ==# 'netrw'
        let l:root = get(b:, 'netrw_curdir', getcwd())
        wincmd p
    endif

    let l:path = fnamemodify(l:root . '/' . l:name, ':p')

    execute 'edit ' . fnameescape(l:path)

    if !filereadable(l:path)
        write
    endif    
endfunction

nnoremap <silent> <leader>n :call NewFile()<CR>

nmap <silent> <leader>rn R
nmap <silent> <leader>rd D

" ==========================================
" CHARACTER ENCODING
" ==========================================
set encoding=utf-8
set fileencodings=utf-8,latin1
set termencoding=utf-8
