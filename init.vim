" Neovim for Elixir
" Josh Adams
" http://www.smoothterminal.com/articles/neovim-for-elixir
"
" Use vim-plug
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Create a vim-plug section in ~/.config/nvim/init.vim
"

call plug#begin('~/.config/nvim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  " use tab for completion
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" uncomment below to disable mouse/cursor in nvim
" set mouse=""
" see help: clipboard
" set clipboard=unnamed

" croshclip
" https://github.com/acornejo/croshclip
" cat /etc/profile.d/croshclip.sh
" nc -z localhost 30001 || croshclip -serve > /tmp/croshclip.log 2>&1 &
  nnoremap "*p :r !croshclip -paste<CR>
  vnoremap "*y :w !croshclip -copy<CR><CR>

  nnoremap "+p :r !croshclip -paste<CR>
  vnoremap "+y :w !croshclip -copy<CR><CR>


" Sane tabs
" - Two spaces wide
  set tabstop=2
  set softtabstop=2

" - Expand them all
  set expandtab

" - Indent by 2 spaces by default
  set shiftwidth=2

" Use comma for leader
  let g:mapleader=','

" Double backslash for local leader - FIXME: not sure I love this
  let g:maplocalleader='\\'

  set number " line numbering
  set encoding=utf-8

" Highlight search results
  set hlsearch

" Incremental search, search as you type
  set incsearch

" Ignore case when searching
  set ignorecase

" Ignore case when searching lowercase
  set smartcase

" Stop highlighting on Enter
  map <CR> :noh<CR>

" highlight cursor position
  set cursorline
  set cursorcolumn

" Set the title of the iterm tab
  set title

" Polyglot loads language support on demand!
  Plug 'sheerun/vim-polyglot'

Plug 'tomasr/molokai'

" Execute code checks, find mistakes, in the background
  Plug 'neomake/neomake'

" Run Neomake when I save any buffer
  augroup localneomake
    autocmd! BufWritePost,BufEnter * Neomake
  augroup END

  let g:neomake_open_list = 2

" Don't tell me to use smartquotes in markdown ok?
  let g:neomake_markdown_enabled_makers = []

" Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
  let g:neomake_elixir_enabled_makers = ['mix', 'mycredo']
  function! NeomakeCredoErrorType(entry)
    if a:entry.type ==# 'F'      " Refactoring opportunities
      let l:type = 'W'
    elseif a:entry.type ==# 'D'  " Software design suggestions
      let l:type = 'I'
    elseif a:entry.type ==# 'W'  " Warnings
      let l:type = 'W'
    elseif a:entry.type ==# 'R'  " Readability suggestions
       let l:type = 'I'
    elseif a:entry.type ==# 'C'  " Convention violation
      let l:type = 'W'
    else
      let l:type = 'M'           " Everything else is a message
    endif
      let a:entry.type = l:type
  endfunction

  let g:neomake_elixir_mycredo_maker = {
        \ 'exe': 'mix',
        \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
        \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
        \ 'postprocess': function('NeomakeCredoErrorType')
        \ }

Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist' " required for some navigation features
Plug 'slashmili/alchemist.vim'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'kana/vim-fakeclip'


call plug#end()

  set background=dark
  syntax enable
  colorscheme molokai

