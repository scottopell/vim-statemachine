function! statemachine#Errorformat()
  return '%f: %l: %m'
endfunction

function! statemachine#GetValidatorExePath()
  return escape('./' . findfile('validator.rb', '.;'), ' \')
endfunction

function! statemachine#GetCompleterExePath()
  return escape('./' . findfile('complete.rb', '.;'), ' \')
endfunction

function! statemachine#GetCurrBuffContents()
  return join(getbufline(bufname('%'), 1, "$"), "\n")
endfunction

function! statemachine#Complete(findstart, base)
  if a:findstart
    echom getline('.')
    return getline('.') =~# '\v^\s*$' ? -1 : 0
  else
    if empty(a:base)
      return []
    endif
    let l:results = []

    " TODO, this seems to be leaving out the current line (or more accurately,
    " its there, but its empty (because I can see an extra \n))
    " TODO, this shouldn't always be \n probably (should be current line
    " ending)
    echom bufname('%')
    echom getline('.')
    let l:file_contents = statemachine#GetCurrBuffContents()

    echom 'file contents here'
    echom l:file_contents

    let l:completions =
                \ system(statemachine#GetCompleterExePath().' '.(eval(line2byte(line('.')) + col('.'))), l:file_contents)
    let l:cmd = substitute(a:base, '\v\S+$', '', '')
    for l:line in split(l:completions, '\n')
      let l:tokens = split(l:line, '\t')
      call add(l:results, {'word': l:cmd.l:tokens[0],
                          \'abbr': l:tokens[0],
                          \'menu': get(l:tokens, 1, '')})
    endfor
    return l:results
  endif
endfunction
