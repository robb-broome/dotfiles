
" Add all directories under $DOTFILES/vim/vendor as runtime paths, so plugins,
" docs, colors, and other runtime files are loaded.
let vendorpaths = globpath("$DOTFILES/vim", "vendor/*")
let vendorruntimepaths = substitute(vendorpaths, "\n", ",", "g")
let vendorpathslist = split(vendorpaths, "\n")

" map the leader key to ",", makes command-t easier to use
let mapleader = ","

" Change cursor shape to reflect mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" CommandT mapped to leader f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>

nnoremap <Leader>rt :!bundle list --paths=true \| xargs ctags --extra=+f --exclude=.git --exclude=log -R *<CR><CR>
" resize current buffer by +/- 5 
nnoremap <D-left> :vertical resize -5<cr>
nnoremap <C-down> :res +5<cr>
nnoremap <C-up> :res -5<cr>
nnoremap <D-right> :vertical resize +5<cr>

execute "set runtimepath^=$DOTFILES/vim,".vendorruntimepaths
for vendorpath in vendorpathslist
  if isdirectory(vendorpath."/doc")
    execute "helptags ".vendorpath."/doc"
  endif
endfor

" Ignore temp files
set wildignore=*~
set wildignore=*.*~


set cpoptions+=$

if bufwinnr(1)
  map + <C-W>+
  map - <C-W>-
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" vundle changes
filetype off
set rtp+=~/dotfiles/vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-vividchalk'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-commentary'
Bundle 'altercation/vim-colors-solarized'

" items from destroyallsoftware 
set winwidth=120
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

set shell=/bin/sh


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction

nnoremap <leader>.  :call OpenTestAlternate()<cr>

function! RunTests(filename)
      " Write the file and run tests for the given filename
      :w
      :silent !echo;echo;echo;echo;echo
      exec ":!bundle exec rspec  -b " . a:filename
endfunction

function! SetTestFile()
  " Set the spec file that tests will be run for.
  let t:grb_test_file=@%
endfunction

function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_spec_file = match(expand("%"), '_spec.rb$') != -1
  if in_spec_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end
  call RunTests(t:grb_test_file .  command_suffix)
endfunction

function! RunNearestTest()
  let spec_line_number = line('.')
  call RunTestFile(":" . spec_line_number)
endfunction

" Run this file
map <leader>t :call RunTestFile()<cr>
" Run only the example under the cursor
map <leader>T :call RunNearestTest()<cr>
" Run all test files
map <leader>a :call RunTests('spec')<cr>
" Switch between the last two files
nnoremap <leader><leader> <c-^>

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		  " keep a backup file
  set backupdir=~/.vimbackups,.
  set backupcopy=yes
endif
set history=50		" keep 50 lines of command line history
set ruler		      " show the cursor position all the time
set showcmd		    " display incomplete commands
set incsearch		  " do incremental searching
set vb            " turn on visual bell
set nu            " show line numbers
set sw=2          " set shiftwidth to 2
set ts=2          " set number of spaces for a tab to 2
set et            " expand tabs to spaces

" fancy statusline
" set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
" set laststatus=2

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default iletype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
  " For all ruby files, set 'shiftwidth' and 'tabspace' to 2 and expand tabs
  " to spaces.
  autocmd FileType ruby,eruby set sw=2 ts=2 et

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Easily open and reload vimrc
",v brings up my .vimrc
",V reloads it -- making all changes active (have to save first)
map ,v :sp $DOTFILES/vimrc<CR>
map <silent> ,V :source $HOME/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Key sequence mappings
cmap %/ <C-r>=expand('%:p:h')<CR>/
" execute current line as shell command, and open output in new window
map ,x :silent . w ! sh > ~/.vim_cmd.out<CR>:new ~/.vim_cmd.out<CR>

" Character mapping
cnoremap <C-a> <Home>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
"Note: below two commands are not what I want, but M-b and M-f don't work,
"need to figure this out.
"cnoremap <Esc>b <S-Left>
"cnoremap <Esc>f <S-Right>

" Sessions ********************************************************************
set sessionoptions=blank,buffers,curdir,folds,help,options,resize,tabpages,winpos,winsize

" " Automatically save and reload sessions
" function! MakeSession()
"   let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
"   if (filewritable(b:sessiondir) != 2)
"     exe 'silent !mkdir -p ' b:sessiondir
"     redraw!
"   endif
"   let b:filename = b:sessiondir . '/session.vim'
"   exe "mksession! " . b:filename
" endfunction

" function! LoadSession()
"   let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
"   let b:sessionfile = b:sessiondir . "/session.vim"
"   if (filereadable(b:sessionfile))
"     exe 'source ' b:sessionfile
"   else
"     echo "No session loaded."
"   endif
" endfunction

" au VimEnter * nested :call LoadSession()
" au VimLeave * :call MakeSession()

" Text formatting
function! WordWrap(state)
  if a:state == "on"
    set lbr
  else
    set nolbr
  end
endfunction
com! WW call WordWrap("on")

" White space
let hiExtraWhiteSpace = "hi ExtraWhitespace ctermbg=red guibg=red"
exec hiExtraWhiteSpace
au ColorScheme * exec hiExtraWhiteSpace
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au BufRead,InsertLeave * match ExtraWhitespace /\s\+$/

" Markdown ******************************************************************
function! PreviewMKD()
  let tmpfile = tempname()
  exe "write! " tmpfile
  exe "!preview_mkd " tmpfile
endfunction
autocmd BufRead *.markdown map <Leader>p :call PreviewMKD()<CR>
autocmd BufRead *.markdown call WordWrap("on")
autocmd BufRead *.markdown set spell

" *** CTAGS *** 
" let Tlist_Ctags_Cmd = "/usr/bin/ctags"
" let Tlist_WinWidth = 50
" map <F4> :TlistToggle<cr>

" Filetypes
au BufRead,BufNewFile *.feature setfiletype cucumber

" Folding *********************************************************************
function! EnableFolding()
  set foldcolumn=2
  set foldenable
endfunction
function! DisableFolding()
  set foldcolumn=0
  set nofoldenable
endfunction
set foldmethod=syntax
call DisableFolding()

" Netrw
let g:netrw_liststyle=3
let g:netrw_browse_split=0
let g:netrw_list_hide='^\..*\.swp$'

" Typewriter Sounds **********************************************************
" function! PlaySound()
"  silent! exec '!afplay ~/.vim/support/9744__Horn__typewriter.aif &'
" endfunction
" autocmd CursorMovedI * call PlaySound()

" Colors *********************************************************************
if has("gui_running")
  " sweet color scheme using true color
  " colorscheme ryan
  "colorscheme Slate
else
  set bg=dark
  " set background=dark
  " colorscheme solarized
end

" Projects *******************************************************************
" function! ConfigureForMMH()
"   set tags=./tags,$MMH_HOME/tags,$MMH_ROOT/stable/tags,$MMH_ROOT/indexer/tags,$MMH_ROOT/jdk_tags,$HOME/tags,tags
" endfunction
" com! Mmh call ConfigureForMMH()

" Java ***********************************************************************
