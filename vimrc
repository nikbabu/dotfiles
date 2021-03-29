   set nocompatible              " be iMproved, required

   "Plug Installation on first load
   if empty(glob('~/.vim/autoload/plug.vim'))
       silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                   \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
       autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
   endif


   "Plug modules
   call plug#begin('~/.vim/plugged')

   Plug 'andymass/vim-matchup'
   Plug 'vim-scripts/Align',{'on':'Align'} 
   Plug 'weynhamz/vim-plugin-minibufexpl' "Actively maintained version of minibufexpl
   Plug 'Yggdroot/indentLine'
   "Plug 'vim-scripts/verilog_systemverilog_fix', {'for': 'verilog' } 
   Plug 'vhda/verilog_systemverilog.vim', {'for': ['verilog', 'verilog_systemverilog'] }
   Plug 'hiberabyss/visincr'
   Plug 'Konfekt/FastFold'
   "Plug 'python-mode/python-mode' , { 'for': 'python', 'branch': 'develop' }
   Plug 'sheerun/vim-polyglot'
   Plug 'tpope/vim-fugitive'
   Plug 'yegappan/taglist'
   Plug 'ctrlpvim/ctrlp.vim'
   Plug 'majutsushi/tagbar'

   call plug#end()


   filetype plugin indent on
   syntax on
   set shiftwidth=4
   set tabstop=4
   set expandtab
   set colorcolumn=121,151
   set laststatus=2
   set cmdheight=1
   set wildmenu
   set showcmd
   set showmatch
   set magic
   set incsearch
   set wrapscan
   set uc=50
   set updatetime=24000
   set autowrite
   set number 
   set shortmess=at
   set ignorecase
   set splitbelow
   set splitright

   "cd to directory when opeining a file in it
   autocmd BufEnter * silent! lcd %:p:h

   if has ('mouse') 
       set mouse=a
   endif

   "Clipboard transfer"
   set clipboard=unnamed
   set go+=a
   noremap <S-Insert> <ESC>"*p`]a

   " keys remapping
   let mapleader="," " leader is comma 
   noremap <F7> :set hls!<CR>
   nnoremap <F11> :ConqueTermTab tcsh<CR>
   noremap <F10> :set wrap!<CR>
   noremap <F9> :set relativenumber! <CR>
   noremap <F12> :set ic!<CR>
   noremap <MouseMiddle> <esc>"*p
   noremap Q <nop>
   noremap <silent> <Leader><space> :nohlsearch<CR>

   " toggle gundo
   noremap <leader>u :GundoToggle<CR>

   " open ag.vim
   nnoremap <leader>a :Ag
   
   "MiniBufExpl settings
   "  let g:miniBufExplSplitToEdge=0
   let g:miniBufExplHideWhenDiff = 1
   let g:miniBufExplBRSplit = 0
   let g:miniBufExplSplitToEdge = 0
   map <silent><leader>q :MBEbd<CR>

   "indentLine settings
   let g:indentLine_char_list = ['|', '¦', '?', '?']

   ""FastFold settings
   augroup setting_fastfold " {
   nmap zuz <Plug>(FastFoldUpdate)
   let g:fastfold_savehook = 1
   let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
   let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
   let g:markdown_folding = 1
   let g:tex_fold_enabled = 1
   let g:vimsyn_folding = 'af'
   let g:xml_syntax_folding = 1
   let g:javaScript_fold = 1
   let g:sh_fold_enabled= 7
   let g:ruby_fold = 1
   let g:perl_fold = 1
   let g:perl_fold_blocks = 1
   let g:r_syntax_folding = 1
   let g:rust_fold = 1
   let g:php_folding = 1
   xnoremap iz :<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zv[z<cr>
   xnoremap az :<c-u>FastFoldUpdate<cr><esc>:<c-u>normal! ]zV[z<cr>
   augroup END " }

   au BufNewFile,BufRead *.medic set syntax=perl
   au BufNewFile,BufRead *.ref,*.vpref set syntax=manuals
   au BufNewFile,BufRead *.js set syntax=javascript
   "au BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
   autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
   au BufNewFile,BufRead *.v,*.vh,*.vt,*.gv,*.bvrl,*.vlib set ft=verilog syntax=verilog_systemverilog 
   au BufNewFile,BufRead *.svh,*.sv,*.svt,*.v,*.vh,*.vt,*.gv,*.vlib set ft=verilog_systemverilog syntax=verilog_systemverilog 
   autocmd FileType c,cpp,java,php,verilog_systemverilog autocmd BufWritePre <buffer> %s/\s\+$//e
   
   " AutoReload vimrc when written
   augroup reload_vimrc " {
       autocmd!
       autocmd BufWritePost $MYVIMRC source $MYVIMRC
   augroup END " }

   "" allows cursor change in tmux mode
   "if exists('$TMUX')
   "    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
   "    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
   "else
   "    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
   "    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
   "endif

   "let g:verilog_syntax_fold_lst="class,function,task,interface,block_named"
   "Move Backups to /tmp directory
   set backup
   set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
   set backupskip=/tmp/*,/private/tmp/*
   set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
   set writebackup

   "Shift Insert must paste
   map <S-Insert> <MiddleMouse>
   map! <S-Insert> <MiddleMouse>
      " Search for selected text, forwards or backwards.
   vnoremap <silent> * :<C-U>
               \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
               \gvy/<C-R><C-R>=substitute(
               \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
               \gV:call setreg('"', old_reg, old_regtype)<CR>
   vnoremap <silent> # :<C-U>
               \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
               \gvy?<C-R><C-R>=substitute(
               \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
               \gV:call setreg('"', old_reg, old_regtype)<CR>


endif


