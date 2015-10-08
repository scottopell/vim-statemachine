echom "hello compiler"
if exists('current_compiler')
    finish
endif

echom "hello statemachine"

let s:validator_loc = escape(findfile('validator.sh', '.;'), ' \')
let current_compiler = s:validator_loc

CompilerSet makeprg=s:validator_loc\ %
execute 'CompilerSet errorformat='.escape(statemachine#errorformat(), ' ')
echom "hello world2"
