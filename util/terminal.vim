if &shell == 'cmd.exe'
  let g:neoterm_shell = $GIT_INSTALL_ROOT . "/bin/bash"
else
  let g:neoterm_shell = "bash"
  let g:neoterm_marker = ';#neoterm'
endif
let g:neoterm_default_mod = "botright"
let g:neoterm_size = 10
let g:neoterm_autoscroll = 1
let g:neoterm_autojump = 1
let g:neoterm_auto_repl_cmd = 0
if has("win32")
  let g:neoterm_eof = "\r"
endif

function s:refresh_layout()
  if g:NERDTree.IsOpen()
    call NERDTreeFocus()
    execute 'wincmd H'
    execute 'vertical resize ' . g:NERDTreeWinSize
    execute 'wincmd p'
  endif
endfunction
autocmd filetype neoterm call s:refresh_layout() 

function s:get_visible_neoterm_ids()
  let l:result=[]
  for l:instance in values(g:neoterm.instances)
    if bufwinnr(l:instance.buffer_id) > 0
      call add(l:result, l:instance.id)
    endif
  endfor
  return l:result
endfunction

function s:hide_neoterm_list(list)
  for l:term_id in a:list
    call neoterm#close({ 'target': l:term_id}) 
  endfor
endfunction

let g:last_neoterm_id=-1
function ToggleTerminal()
  let l:visible_term=s:get_visible_neoterm_ids()
  if len(l:visible_term) > 0
    let g:last_neoterm_id=l:visible_term[0]
    call s:hide_neoterm_list(l:visible_term)
  else
    if g:last_neoterm_id <= -1
      call neoterm#new()
    else
      call neoterm#open({ 'target': g:last_neoterm_id })
    endif
  endif
endfunction
nnoremap <M-t> :call ToggleTerminal()<CR>

function NewTerminal()
  call s:hide_neoterm_list(s:get_visible_neoterm_ids())
  call neoterm#new()
endfunction
nnoremap <M-T> :call NewTerminal()<CR>

tnoremap <Esc> <C-\><C-N>
