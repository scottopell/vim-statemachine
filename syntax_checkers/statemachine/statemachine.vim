if exists('g:loaded_syntastic_statemachine_statemachine_checker')
  finish
endif
let g:loaded_syntastic_statemachine_statemachine_checker = 1

let s:save_cpo = &cpo
set cpo&vim


function! SyntaxCheckers_statemachine_statemachine_GetLocList() dict
  " TODO switch the 'exe' here to 'exec'
  let l:makeprg = self.makeprgBuild({'exe': statemachine#GetValidatorExePath() })
  return SyntasticMake({'makeprg': l:makeprg,
                       \ 'errorformat': statemachine#Errorformat() })
endfunction

function! SyntaxCheckers_statemachine_statemachine_IsAvailable() dict
  " TODO make this actually check whether or not its available
  return 1
endfunction


call g:SyntasticRegistry.CreateAndRegisterChecker({'filetype': 'statemachine',
                                                  \'name': 'statemachine'})

if exists('g:syntastic_extra_filetypes')
  call add(g:syntastic_extra_filetypes, 'statemachine')
else
  let g:syntastic_extra_filetypes = ['statemachine']
endif

let &cpo = s:save_cpo
unlet s:save_cpo
