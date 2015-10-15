if exists('current_compiler')
  finish
endif

" Essentially a polyfill for old versions of vim
if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif


let current_compiler = statemachine#GetExePath()

execute 'CompilerSet makeprg=' . statemachine#GetExePath() . '\ %'
execute 'CompilerSet errorformat='.escape(statemachine#Errorformat(), ' ')
