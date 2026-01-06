set number

set noexpandtab
set tabstop=2
set softtabstop=2 
set shiftwidth=2
set autoindent

set ignorecase
set smartcase
set incsearch
" set nohlsearch

set cursorline
highlight CursorLine gui=NONE cterm=NONE ctermbg=lightgrey guibg=lightgrey
highlight CursorLineNr gui=bold cterm=bold guifg=#A34D14 ctermfg=130

set spell
set spelllang=en_gb,pt_br

" Vertical ruler
set colorcolumn=121
highlight ColorColumn ctermbg=lightgrey guibg=lightgrey

" Cursor definition (use guicursor OR variables):
" n=normal, v=visual, c=command, i=insert, r=replace, o=operator, ci/cr -> variations
" SI=start insert, EI=end insert, SR=start replace
" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
let &t_EI = "\e[2 q"

augroup RestoreCursorShape
	autocmd!
	autocmd VimLeave * silent !echo -ne "\e[6 q"
augroup END
