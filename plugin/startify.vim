let g:startify_bookmarks = systemlist("cut -sd\" \" -f 2 ".$HOME."/.NERDTreeBookmarks")
let g:startify_commands = [['VimWiki Index', 'VimwikiIndex']]
let g:startify_lists = [
			\ { 'type': 'commands',  'header': ['   Commands'       ]},
			\ { 'type': 'bookmarks', 'header': ['   Bookmakrs'      ]},
			\ { 'type': 'sessions',  'header': ['   Sessions'       ]},
			\ { 'type': 'files',     'header': ['   MRU'            ]},
			\ { 'type': 'dir',       'header': ['   MRU ' . getcwd()]}
			\]
