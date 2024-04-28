" reload :so[urce]! ~/.vimrc
" ALT map
" set keyprotocol=kitty:kitty,foot:kitty,wezterm:kitty,xterm:mok2
"let &t_TI = "\<Esc>[>4;2m"
"let &t_TE = "\<Esc>[>4;m"
"let &t_TI = ""
"let &t_TE = ""
let &t_ut=''

set termguicolors
colorscheme nord

filetype plugin indent on
filetype detect
" set foldenable
" set foldmethod=marker
" au FileType sh let g:sh_fold_enabled=7
" au FileType sh let g:is_bash=1
" au FileType sh set foldmethod=syntax
syntax enable

"pas de compatibilité avec vi
set nocompatible
set hidden
set encoding=utf-8
set showtabline=0

" tabulation et indentation
set tabstop=4 softtabstop=4
set shiftwidth=4
" set expandtab
set smartindent

" backspace pour inclure début ligne et tab
set backspace=indent,eol,start

" on active la coloration syntaxique
syntax on

" activation de la surbrillance pour la recherche
set hlsearch
" recherche incrémental
set incsearch

" entete de lignes (colones)
set foldcolumn=2

" wildmenu
set wildchar=<Tab> wildmenu wildmode=full

" je sais plus
"autocmd VimEnter * nested if argc() == 0 && bufname("%") == "" && bufname("2" + 0) != "" | exe "normal! `0" | endif
au BufWrite,BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" acitavion numérotation des lignes
set relativenumber
set number
" activé les numéros de lignes relatives uniquement si focus
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
	autocmd BufLeave,FocusLost,WinLeave   * if &nu                  | set nornu | endif
augroup END

" hauteur ligne de commande
set cmdheight=2

" ajoute une colonne pour plus infos
set signcolumn=yes

" txt / pas de number,etc...
" autocmd Filetype *.txt set nonumber
" autocmd Filetype *.txt set signcolumn=no
" autocmd Filetype *.txt set foldcolumn=0
au BufEnter *.txt set spell spelllang=fr
au BufEnter *.txt set nonumber
au BufEnter *.txt set nornu
au BufEnter *.txt set signcolumn=no
au BufEnter *.txt set foldcolumn=0
" au BufEnter *.txt set laststatus=0
set laststatus=0


" colonne à 80 (juste la couleur)
" set colorcolumn=80

" CURSOR
" set nocursorline
set cursorline
" switch cursorline when enter/leave insermode
autocmd InsertEnter,InsertLeave * set cul!
" let &t_SI = "\jesc>[4 q"  " blinking I-beam in insert mode
" let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
" let &t_EI = "\<esc>[ q"  " default cursor (usually blinking block) otherwise


" continue le déplacement en fin de ligne à ligne suivante
" continue le déplacement en début de ligne à ligne précédente
set whichwrap=<,>,[,],h,l 

" garde 8 ligne au début et à la fin lors des scroll
set scrolloff=8

" active l'affichage des char spéciaux
set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
"set listchars=eol:¶,space:·,lead:•,trail:•,nbsp:◇,tab:→\ ,extends:▸,precedes:◂,leadmultispace:\│\ \ \ ,
set nolist

" ligne de fold.
set foldtext=MyFoldText()
function! MyFoldText()
	let separateur = ' | '
	let line1 = getline(v:foldstart)
	if line1 =~ "^#"
		let mytext = substitute(line1,'^#\ *','','')
		let line2 = getline(v:foldstart+1)
		if line2 =~ '^# *' && strlen(substitute(line2,'^#\ *','','')) > 0
			let mytext = mytext.separateur.substitute(line2,'^#\ *','','')
		endif
	else
		let mytext = getline(v:foldstart)
	endif
	let infos = '( '.(v:foldend-v:foldstart + 1).' lines )'
	return mytext.separateur.infos.separateur
	" return strpart( mytext, 0, &columns - strlen(infos)).infos
endfunction

" séparteur de fenêtre séparée
set fillchars+=vert:│

"activation/desactivation du paste
"set paste
"set pastetoggle=tk

" maleader key => space
let mapleader = " "
"nnoremap <leader>ps :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})<CR>

" no spell by default
set nospell
nnoremap <silent> <leader>ss :set spell!<cr>
" nnoremap <leader>s :set spell!<cr>

" rust
let g:rust_fold=2
" abreviation - rust
" ab print println!("{}")<esc>3j
" ab strf String::from("")<esc>2<left>
" ab str String

" bash
:autocmd Filetype sh :iabbrev bash! #!/bin/bash
:autocmd Filetype sh :iabbrev bashx! #!/bin/bash -x
:autocmd Filetype sh :iabbrev while! while; do<esc>o<esc>odone<esc>2i2lh
:autocmd Filetype sh :iabbrev for! for; do<esc>o<esc>odone<esc>2ih
:autocmd Filetype sh :iabbrev foreach! for i in ${![@]}; do<cr><cr>done<UP><UP><esc>8<RIGHT>a

" C
:autocmd Filetype c,h :iabbrev d! #define 
:autocmd Filetype c,h :iabbrev i! #include <
:autocmd Filetype c,h :iabbrev io! #include <stdio.h><cr>
:autocmd Filetype c,h :iabbrev il! #include <stdlib.h><cr>
:autocmd Filetype c,h :iabbrev iu! #include <stdint.h><cr>
:autocmd Filetype c,h :iabbrev is! #include <string.h><cr>
:autocmd Filetype c,h :iabbrev ia! #include <assert.h><cr>
:autocmd Filetype c,h :iabbrev ie! #include <errno.h><cr>
:autocmd Filetype c,h :iabbrev ib! #include <stdbool.h><cr>
:autocmd Filetype c,h :iabbrev ii! 
\#include <stdio.h>
\<cr>#include <stdlib.h>
\<cr>#include <stdint.h>
\<cr>#include <string.h>
\<cr>#include <stdbool.h>
\<cr>

:autocmd Filetype c :iabbrev main! int main(int argc, char *argv[]) {<CR>XXX;<CR>return 0;}<CR><Esc>?XXX<CR>cw
:autocmd Filetype c :iabbrev mainv! void main() {<CR>XXX;}<CR><Esc>?XXX<CR>cw
:autocmd Filetype c :iabbrev maine! int main(int argc, char *argv[], char *envp[]) {<CR>XXX;}<CR><Esc>?XXX<CR>cw
:autocmd Filetype c :iabbrev fori for (i=0; i<=XXX; i++) {<CR><CR>}<Esc>?XXX<CR>cw
" :autocmd Filetype c set foldmethod=syntax 
" :autocmd Filetype c set nofoldenable
" :autocmd Filetype c set foldlevel=1

:iabbrev lorem! 
\Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium
\doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore
\veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim
\ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia
\consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque
\porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur,
\adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et
\dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis
\nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex
\ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea
\voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem
\eum fugiat quo voluptas nulla pariatur?

" keyboard shortcuts
" inoremap	<silent> <F10>	<ESC>:Vex<CR><CTRL-w>-5
inoremap	<silent> <F2>	<ESC>:w<CR>":i<CR>

nnoremap <silent> <Space><Space> :nohlsearch<Bar>:echo<CR>

"noremap <F4> :set hlsearch! hlsearch?<CR>
"nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

" mouvement azerty
noremap i k
noremap k j
noremap j h
noremap h i

" on remap i vers h
nnoremap <S-h> <S-i>
vnoremap <S-h> <S-i>

" on désactive i
nnoremap <S-i> nop
vnoremap <S-i> nop

inoremap <C-h> nop
" nnoremap <Tab> \>\>_
" nnoremap <S-Tab> \<\<_
"inoremap <S-Tab> <C-D>
"inoremap <Tab> <C-T>
vnoremap <tab> >
vnoremap <s-tab> <
" mouvement alt+ en mode insertion
inoremap <M-k> <down>
inoremap <M-j> <left>
inoremap <M-l> <right>
inoremap <M-i> <up>
"commande mode
cnoremap <M-k> <down>
cnoremap <M-j> <left>
cnoremap <M-l> <right>
cnoremap <M-i> <up>
vnoremap <M-k> <down>
vnoremap <M-j> <left>
vnoremap <M-l> <right>
vnoremap <M-i> <up>
" inoremap <> <C-\><C-o>b
" inoremap <> <C-\><C-o>w
"inoremap <M-i> <up>

"inoremap <M-k> <down>
"inoremap <M-j> <left>
"inoremap <M-l> <right>

" move
inoremap <M-u> <PageUp>
inoremap <M-o> <PageDown>
" inoremap <C-M-j> <S-left>
" inoremap <C-M-l> <S-right>
" vnoremap <C-M-j> <S-left>
" vnoremap <C-M-l> <S-right>
" déplacement des lignes vers le haut et le bas
nnoremap <C-i> :m .-2<CR>==
nnoremap <C-k> :m .+1<CR>==
vnoremap <C-i> :m '<-2<CR>gv=gv
vnoremap <C-k> :m '>+1<CR>gv=gv

inoremap <A-S-K> <Esc>:m .+1<CR>==gi
inoremap <A-S-I> <Esc>:m .-2<CR>==gi

" echape 
inoremap <C-cr> <ESC>

" suppression char sous curseur
" inoremap xx <DEL>

" ale (linter)
nmap <silent> <A-l> <Plug>(ale_previous)
nmap <silent> <A-m> <Plug>(ale_next)

" NERDTree
" nnoremap <leader>f :NERDTreeFocus<CR>
" nnoremap <leader>f :NERDTreeToggle<CR>
" nnoremap <C-n> :NERDTree<CR>
" nnoremap <C-t> :NERDTreeToggle<CR>
" nnoremap <C-f> :NERDTreeFind<CR>
let NERDTreeMapUpdir='i'
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" auto close
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"
"
" tab shorcut
"inoremap <M-l> <esc>tabnext

" plugins
"
call plug#begin()
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" Plug 'rust-lang/rust.vim'
Plug 'preservim/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
" Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'szw/vim-ctrlspace'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'dense-analysis/ale'
" Plug 'scrooloose/nerdtree'
Plug 'fladson/vim-kitty'
" Plug 'https://github.com/vim-syntastic/syntastic.git'
" Plug 'vim-ctrlspace/vim-ctrlspace'
" Plug 'https://github.com/vim-ctrlspace/vim-ctrlspace.git'
Plug 'jlanzarotta/bufexplorer'
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
call plug#end()
" Man
runtime ftplugin/man.vim

" nerdcommenter
let g:NERDDefaultAlign='start'
let g:NERDSpaceDelims=2
let g:NERDRemoveExtraSpaces=0
let g:NERDCompactSexyComs=1
let g:NERDDefaultNesting=0
" airline
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
let g:ale_cursor_detail = 0
let g:ale_virtualtext_cursor = 0
let g:ale_detail_to_floating_preview=1
" let g:ale_detail_to_floating_preview=1
let g:airline_theme='minimalist'
let g:airline_powerline_fonts=1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_c_only_filename = 1
" let g:airline_detect_spell=1
" let g:airline_detect_spelllang='flag'
let g:airline#extensions#ctrlspace#enabled=1
let g:CtrlSpaceStatuslineFunction="airline#extensions#ctrlspace#statusline()"
let g:airline#extensions#fzf#enabled=1
let g:airline#extensions#syntastic#enabled=1

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" fzf
" let g:fzf_preview_window = ['right,50%', 'ctrl-b']

" disable mode display
" set noshowmode

" macro
let @z='V][zf'
nnoremap <leader>z @z

"fzf
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <leader>fb :Buffers<CR>

" buffer
nnoremap <silent> <leader>b :ls<cr>:b<space>
nnoremap <silent> <leader>l :bn<cr>
nnoremap <silent> <leader>j :bp<cr>
" 8a : ctrl+alt+j
" 8c : ctrl+alt+l
nnoremap <silent>  :bn<cr>
nnoremap <silent>  :bp<cr>
inoremap <silent>  <esc>:bn<cr>i
inoremap <silent>  <esc>:bp<cr>i
vnoremap <silent>  :bn<cr>
vnoremap <silent>  :bp<cr>

set wildcharm=<C-Z>
nnoremap <F10> :b <C-Z>

" nmap <silent> <F5> :set relativenumber! number! showmode! showcmd! hidden! ruler!<CR> :set laststatus=0<CR>
" nmap <silent> <F6> :set relativenumber! number! showmode! showcmd! hidden! ruler!<CR> :set laststatus=2<CR>

" ascii art
vmap <leader>ts :!toilet -w 200 -F border -f standard<CR>
vmap <leader>tp :!toilet -w 200 -f pagga<CR>
vmap <leader>ttp :!toilet -w 200 -F border -f pagga<CR>
vmap <leader>te :!toilet -w 200 -F border -f emboss<CR>
vmap <leader>tr :!toilet -w 200 -F border -f term<CR>
vmap <leader>tt :!toilet -w 200 -F border -f term<CR>

" check mark
inoremap <silent> <F3> ✓
nnoremap <silent> <F3> <esc>r✓
vnoremap <silent> <F3> <esc>r✓

" telescope
" nnoremap <leader>ff <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>fb <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Creating splits with empty buffers in all directions
nnoremap <Leader>sj :leftabove  vnew<CR>
nnoremap <Leader>sl :rightbelow vnew<CR>
nnoremap <Leader>si :leftabove  new<CR>
nnoremap <Leader>sk :rightbelow new<CR>

" split resize
map + <C-w>+
map - <C-w>-

" C dev / gcc / gdb / ...
packadd termdebug
let g:termdebug_wide = 1
nnoremap <Leader>dg :Termdebug<CR>

" shwitch case (remember the original position. use w as marker)
nnoremap <silent> <leader>, mwg~iw`w
nnoremap <silent> <leader>; mwgUiw`w
nnoremap <silent> <leader>: mwguiw`w
" nnoremap <leader>, bve~
" nnoremap <leader>n g~be

" leader+leader for jump to marks
nnoremap <silent> <Leader>i '
nnoremap <silent> <Leader>ii ''

" registres
nnoremap <silent> <Leader>k "
nnoremap <silent> <Leader>kk "a
nnoremap <silent> <Leader>kq "z
nnoremap <silent> <Leader>ks "e
nnoremap <silent> <Leader>kd "r

" g go to...
nnoremap <silent> <Leader>g gd:nohls<cr>

" duplicate ligne after above
nnoremap <silent> <Leader>p <UP>yy<DOWN>p

" bash add/remove trace
" inoremap <silent> <leader>x <esc>A -x
nnoremap <silent> <leader>x A -x<esc>
" inoremap <silent> <leader>xd <esc>:s/ -x$//<CR>A
nnoremap <silent> <leader>xd :s/ -x$//<CR>

" inoremap <leader>xi <esc>oset  -x
nnoremap <leader>xk oset -x<esc>
" inoremap <leader>xk <esc>oset +x<esc>
nnoremap <leader>xi oset +x<esc>

" delete until next "
nnoremap <silent> <Leader>d" dt"
" Begin and End of file
inoremap <silent> <C-S-i> <C-o>gg
inoremap <silent> <C-S-k> <C-o>G

" {  }
inoremap <silent> <A-;> {
inoremap <silent> <A-:> }
inoremap <silent> <C-;> [
inoremap <silent> <C-:> ]
 
" man
nnoremap <silent> <S-k> <leader>K
