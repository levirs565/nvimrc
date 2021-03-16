if &shell == 'cmd.exe'
  let g:neoterm_shell = "pwsh"
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
