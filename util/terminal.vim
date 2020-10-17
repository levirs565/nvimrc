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

