let g:startify_bookmarks = [] 
for line in readfile($HOME."/.NERDTreeBookmarks")
  let line = trim(line)
  if empty(line)
    continue
  endif
  let file = join(split(line, '\s\+')[1:])
  call add(g:startify_bookmarks, file)
endfor

let g:startify_commands = [['VimWiki Index', 'VimwikiIndex']]
let g:startify_lists = [
			\ { 'type': 'commands',  'header': ['   Commands'       ]},
			\ { 'type': 'bookmarks', 'header': ['   Bookmakrs'      ]},
			\ { 'type': 'sessions',  'header': ['   Sessions'       ]},
			\ { 'type': 'files',     'header': ['   MRU'            ]},
			\ { 'type': 'dir',       'header': ['   MRU ' . getcwd()]}
			\]
