set shell=powershell

function RefreshLayout()
  if g:NERDTree.IsOpen()
    call NERDTreeFocus()
    execute 'wincmd H'
    execute 'vertical resize ' . g:NERDTreeWinSize
    execute 'wincmd p'
  endif
endfunction

let terminalbuffer='slider-terminal'
function ToggleTerminal()
  let window=bufwinnr(g:terminalbuffer)
  let bufexists=bufexists(g:terminalbuffer)
  
  if window > 0
    "window is show, hide it
    execute window . 'hide'
  else
    "window is not show, show it
    execute 'botright new'
    execute 'resize 10'
    call RefreshLayout()
    
    if bufexists
      execute 'buffer ' . g:terminalbuffer
    else
      execute 'set nonumber'
      execute 'term'
      execute 'file ' . g:terminalbuffer
    endif
  endif
endfunction

nnoremap <M-t> :call ToggleTerminal()<CR>
tnoremap  

