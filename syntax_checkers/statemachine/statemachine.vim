if exists('g:loaded_syntastic_statemachine_statemachine_checker')
  finish
endif
let g:loaded_syntastic_statemachine_statemachine_checker = 1

let s:save_cpo = &cpo
set cpo&vim


function! SyntaxCheckers_statemachine_statemachine_GetLocList() dict
  let l:makeprg = self.makeprgBuild({'exe': statemachine#GetExePath() })
  echom 'huh'
  echom statemachine#Errorformat()
  return SyntasticMake({'makeprg': l:makeprg,
                       \ 'errorformat': statemachine#Errorformat() })
endfunction

function! SyntaxCheckers_statemachine_statemachine_IsAvailable() dict
  return 1
endfunction


call g:SyntasticRegistry.CreateAndRegisterChecker({'filetype': 'statemachine',
                                                  \'name': 'statemachine'})

let &cpo = s:save_cpo
unlet s:save_cpo
