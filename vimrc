if !empty($WINDOWID)
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
   Plug 'mrk21/yaml-vim' , {'for': 'yaml' }
   "Plug 'python-mode/python-mode' , { 'for': 'python', 'branch': 'develop' }
   Plug 'hiberabyss/visincr' ,{'on':'I'} 
   Plug 'Konfekt/FastFold'
   Plug 'sheerun/vim-polyglot'
   Plug 'tpope/vim-fugitive'
   Plug 'yegappan/taglist'
   Plug 'ctrlpvim/ctrlp.vim'
   Plug 'majutsushi/tagbar'
   Plug '~nbabu/vimplugs/verilog_systemverilog'  , {'for': ['verilog', 'verilog_systemverilog' ] }
   Plug  '~nbabu/vimplugs/verilog-support' , {'for': ['verilog', 'verilog_systemverilog' ] }
   Plug '~nbabu/vimplugs/viva' , {'for': 'viva'}
  

au BufNewFile,BufRead *.vx,*.svx,*.svtx set ft=viva
au BufNewFile,BufRead *.v,*.vh,*.vt,*.gv,*.bvrl,*.vlib set ft=verilog syntax=verilog_systemverilog 
au BufNewFile,BufRead *.svh,*.sv,*.svt,*.v,*.vh,*.vt,*.gv,*.vlib set ft=verilog_systemverilog syntax=verilog_systemverilog 

   "if !empty($TMUX)
   "    Plug 'tmux-plugins/vim-tmux-focus-events'
   "    Plug 'roxma/vim-tmux-clipboard'
   "endif
   

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
   set lazyredraw
   set hls

   "colorscheme pablo 
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
   "nnoremap <F11> :ConqueTermTab tcsh<CR>
   noremap <F11> :set wrap!<CR>
   nnoremap <silent> <F10> :TlistToggle<CR>
   noremap <F9> :set relativenumber! <CR>
   noremap <F12> :set ic!<CR>
   noremap <MouseMiddle> <esc>"*p
   noremap Q <nop>
   noremap <silent> <Leader><space> :nohlsearch<CR>

   " toggle gundo
   "noremap <leader>u :GundoToggle<CR>


   "MiniBufExpl settings
   "  let g:miniBufExplSplitToEdge=0
   let g:miniBufExplHideWhenDiff = 1
   " let g:miniBufExplBRSplit = 0
   let g:miniBufExplSplitToEdge = 0
   map <silent><leader>q :MBEbd<CR>

   "indentLine settings
   let g:indentLine_char_list = ['|', '¦', '.' , '!']

   "Ctrlp settings
   let g:ctrlp_working_path_mode = 'ra'
   let g:ctrlp_root_markers = ['.git','.p4config', 'TOE']
   set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*simv.diadir*
"   let g:ctrlp_custom_ignore = {
"               \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"               \ 'file': '\v\.(exe|so|dll)$',
"               \ 'link': 'some_bad_symbolic_links',
"               \ }
   let g:ctrlp_custom_ignore = {
               \ 'dir':  '\v[\/]\.(git|hg|pwastate)$',
               \ 'file': '\v\.(exe|so|dll)$',
               \ }


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
   set sessionoptions-=folds
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

   "Move Backups to /tmp directory
   set backup
   set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
   set backupskip=/tmp/*,/private/tmp/*
   set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
   set writebackup

   "Shift Insert must paste
   map <S-Insert> <MiddleMouse>
   map! <S-Insert> <MiddleMouse>

   nmap <F2> :TagbarToggle<CR>
   "use ] and [ instead of ]c and [c to navigate between diff segments
   if &diff
       set cursorline
       map ] ]c
       map [ [c
       hi DiffAdd    ctermfg=233 ctermbg=LightGreen guifg=#003300 guibg=#DDFFDD gui=none cterm=none
       hi DiffChange ctermbg=white  guibg=#ececec gui=none   cterm=none
       hi DiffText   ctermfg=233  ctermbg=yellow  guifg=#000033 guibg=#DDDDFF gui=none cterm=none
   endif

   " Delete trailing white space on save, useful for Python and CoffeeScript ;)
   "func! DeleteTrailingWS()
   "    exe "normal mz"
   "    %s/\s\+$//ge
   "    exe "normal `z"
   "endfunc
   
   "au BufNewFile,BufRead *.vh,*.sv,*.v,*.vpl,*.vtpp,*.vx,*.xh,*.vxh,*.vxctx,*.vxp,*.gv,*.vt,*.vc,*.mc,*.pi,*.m4,*.mch,*.scr,*.log,*.txt,*.err,*.rat,*.report,*.dcsh,*.fmsh,*.con,*.newcon,*.conext,*.setup,*.spec,*.generated_spec,*.hier_map,*.rep,*.mfs,*.vcp,*.desc,*.template so /home/nbabu/.vim_sv_rc.vim
   "au BufNewFile,BufRead *.vx,*.svx,*.svtx,*.v,*.vh,*.vt,*.gv,*.vlib,*.svh,*.sv,*.svt,*.v,*.vh,*.vt,*.gv,*.vlib so /home/nbabu/.vim_sv_rc.vim
   "set ft=verilog syntax=verilog_systemverilog 
   au BufNewFile,BufRead *.log,JOB.out set ft=log
   au BufNewFile,BufRead testout set ft=log
   au BufNewFile,BufRead *.medic set syntax=perl
   au BufNewFile,BufRead *.ref,*.vpref set syntax=manuals
   au BufNewFile,BufRead *.js set syntax=javascript
   au BufNewFile,BufRead Makeppfile so /home/utils/vim-7.1/share/vim/vim71/syntax/make.vim
   au BufNewFile,BufRead *.testlist so /home/nbabu/.vim/syntax/testlist.vim
   "au BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
   autocmd FileType yaml setlocal ts=4 sts=4 sw=4 expandtab
   autocmd FileType c,cpp,java,php,verilog_systemverilog autocmd BufWritePre <buffer> %s/\s\+$//e

   "Tags settings
   "
   let var=system("pwa info root --chomp")
   if !empty(glob(var))
       let var.="/tags"
       execute "set tags=".var
   endif

   "pythonmode settings
   "Turn off plugin's warnings.     
   let g:pymode_warnings = 0
   "Setup default python options.
   let g:pymode_options = 1

    "augroup systemverilog_settings_2
    "    au!
    "    " Enable folding for normal size files. Folding is really slow for large files.
    "    "let g:verilog_syntax_fold_lst="class,function,task,interface,block_named"
    "    au Filetype verilog_systemverilog set foldmethod=syntax
    "    au Filetype verilog_systemverilog if line('$') < 2000
    "    au Filetype verilog_systemverilog     let g:verilog_syntax_fold_lst = "class,function,task,interface,block_named"
    "    au Filetype verilog_systemverilog     syntax enable "Trigger fold calculation
    "    au Filetype verilog_systemverilog else
    "    au Filetype verilog_systemverilog     let g:verilog_syntax_fold_lst = ""
    "    au Filetype verilog_systemverilog endif
    "augroup END
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
