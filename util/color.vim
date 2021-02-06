" mode:
" auto
" light
" dark
let g:color_mode="auto"
function UpdateColorMode()
  let isLight=g:color_mode=="light"
  
  if g:color_mode=="auto"
    let currentHour=strftime('%H')
    let isLight=currentHour<18
  endif

  if isLight
    set background=light
  else
    set background=dark
  endif
endfunction

function SetColorMode(mode)
  let g:color_mode=a:mode
  call UpdateColorMode()
endf

command! ColorMode call fzf#run(fzf#wrap({
      \ 'source': ['auto', 'light', 'dark'],
      \ 'sink': function("SetColorMode")
      \}))

function GetHiColor(group, what)
  return synIDattr(synIDtrans(hlID(a:group)), a:what)
endf

function UpdateWindowColor()
  let bgColor=GetHiColor('Normal', 'bg#')
  let inactiveBgMix=GetHiColor('Normal', 'fg#')
  let inactiveBgColor=color#Mix(bgColor, inactiveBgMix, 0.04)
  call execute("hi ActiveWindow guibg=".bgColor)
  call execute("hi InactiveWindow guibg=".inactiveBgColor)
endf

augroup ColorUtil
  autocmd!
  autocmd ColorSchemePre * :call UpdateColorMode()
  autocmd ColorScheme * call UpdateWindowColor()
  autocmd WinEnter * call ChangeWinHL(winnr('#'))
augroup END

function! ChangeWinHL(win)
  call setwinvar(a:win, "&winhighlight", "Normal:ActiveWindow,NormalNC:InactiveWindow")
endfunction
