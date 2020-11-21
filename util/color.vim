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

autocmd ColorSchemePre * :call UpdateColorMode()
