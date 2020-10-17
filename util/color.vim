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

