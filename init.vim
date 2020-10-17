set number
"set termguicolors
if exists('+termguicolors')
  "let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  "let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

"let g:netrw_banner = 0
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_altv = 1
"let g:netrw_winsize = 25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'paulondc/vim-nerdtree-open-externally'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

autocmd vimenter * NERDTree

let g:gitgutter_git_executable = 'C:\Program Files\Git\bin\git.exe'

set shell=powershell

let terminalbuffer='slider-terminal'
function ToggleTerminal()
  let window=bufwinnr(g:terminalbuffer)
  let bufexists=bufexists(g:terminalbuffer)
  
  if window > 0
    "window is show, hide it
    execute window . 'hide'
  else
    "window is not show, show it
    execute 'belowright split'
    
    if bufexists
      execute 'buffer ' . g:terminalbuffer
    else
      execute 'set nonumber'
      execute 'term'
      execute 'file ' . g:terminalbuffer
    endif

    execute 'resize 10'
  endif
endfunction

nnoremap <M-t> :call ToggleTerminal()<CR>
tnoremap  

function CreateChoice(msg, list, default)
  let new_list=[]
  let index=0
  for item in a:list
    let new_list=add(new_list, nr2char(48 + index) . " " . item) 
    let index+=1
  endfor
  let choices="&" . join(new_list, "\n&")
  return confirm(a:msg, choices, a:default + 1) - 1
endfunction

function ToggleColorScheme()
  let color_list=getcompletion('', 'color')
  let color_current=index(color_list, g:colors_name)
  
  let color_index=CreateChoice('Select color scheme:', color_list, color_current)
  execute 'colorscheme ' . color_list[color_index]
endfunction

" mode:
" 0, automatic
" 1, light
" 2, dark
let g:color_mode=0
function UpdateColorMode()
  let isLight=g:color_mode==1
  
  if g:color_mode==0
    let currentHour=strftime('%H')
    let isLight=currentHour<18
  endif

  if isLight
    set background=light
  else
    set background=dark
  endif
endfunction

function ToggleColorMode()
  let g:color_mode=CreateChoice('Select color mode:', ['Default', 'Light', 'Dark'], g:color_mode)
  :call UpdateColorMode()
endfunction

nnoremap <M-`> :call ToggleColorScheme()<CR>
nnoremap ` :call ToggleColorMode()<CR> 
autocmd ColorSchemePre * :call UpdateColorMode()

colorscheme gruvbox
nmap <M-1> :NERDTreeToggle<CR>
