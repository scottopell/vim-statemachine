setlocal foldmethod=expr
setlocal foldexpr=GetStateMachineFold(v:lnum)

function! GetStateMachineFold(lnum)
  if getline(a:lnum) =~? '\v^\s*$'
    return '-1'
  endif

  return '0'
endfunction

function! IndentLevel(lnum)
  return indent(a:lnum) / &shiftwidth
endfunction
