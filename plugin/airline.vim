let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#tabline#enabled = 1
function! AirlineInit()
  let g:airline_section_x = airline#section#create([])
  let g:airline_section_y = airline#section#create([])
  let g:airline_section_z = airline#section#create(['linenr', 'maxlinenr', ':%v'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
