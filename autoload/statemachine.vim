function! statemachine#Errorformat()
  return '%f: %l: %m'
endfunction

function! statemachine#GetValidatorExePath()
  return escape('./' . findfile('validator.rb', '.;'), ' \')
endfunction

function! statemachine#GetCompleterExePath()
  return escape('./' . findfile('complete.rb', '.;'), ' \')
endfunction

function! statemachine#Complete(findstart, base)
  if a:findstart
    return getline('.') =~# '\v^\s*$' ? -1 : 0
  else
    if empty(a:base)
      return []
    endif
    let l:results = []

    let l:file_contents_list = getbufline('', 'w0', 'w$')
    " TODO, this seems to be leaving out the current line (or more accurately,
    " its there, but its empty (because I can see an extra \n))
    let l:file_contents = ''
    " TODO, this shouldn't always be \n probably (should be current line
    " ending)
    for l:line in l:file_contents_list
      let l:file_contents .= l:line . '\n'
    endfor

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
