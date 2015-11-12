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
  return join(getline(1, "$"), "\n")
endfunction

function! statemachine#Complete(findstart, base)
  if a:findstart
    return getline('.') =~# '\v^\s*$' ? -1 : 0
  else
    if empty(a:base)
      return []
    endif
    let l:results = []

    let l:file_contents = statemachine#GetCurrBuffContents()

    " line2byte(line('.')) gives the number of bytes in the buffer up until
    " this point. This is the place that the base needs to be inserted at
    let l:byte_index = line2byte(line('.'))
    let l:completion_point = l:byte_index + len(a:base)
    let l:full_file_contents = strpart(l:file_contents, 0, l:byte_index).a:base.(strpart(l:file_contents, l:byte_index))
    echom 'full file contents here'
    echom l:full_file_contents
    echom 'current index | completion_point'
    echom l:byte_index.' | '.l:completion_point

    let l:completions =
                \ system(statemachine#GetCompleterExePath().' '.l:completion_point, l:full_file_contents)
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
