function CreateChoice(msg, list, default)
  let new_list=[]
  let index=0
  for item in a:list
    let new_list=add(new_list, nr2char(48 + index) . " " . item) 
    let index+=1
  endfor
  let choices="&" . join(new_list, "\n&")
  return confirm(a:msg, choices, a:default + 1) - 1
endfunction

