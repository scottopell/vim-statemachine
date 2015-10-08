if exists('g:loaded_syntastic_statemachine_statemachine_checker')
    finish
endif
let g:loaded_syntastic_statemachine_statemachine_checker = 1

function! SyntaxCheckers_statemachine_statemachine_GetLocList() dict
    let l:makeprg = self.makeprgBuild({'args': ''})
    echom 'inside getloclist'
    return SyntasticMake({'makeprg': l:makeprg,
                         \ 'errorformat': statemachine#errorformat() })
endfunction


call g:SyntasticRegistry.CreateAndRegisterChecker({'filetype': 'statemachine',
                                                  \'name': 'statemachine'})
