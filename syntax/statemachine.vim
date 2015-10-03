syntax keyword smKeyword input signal output set if goto end and
syntax keyword smFunction state

syntax match smOperator "\v\=\="
syntax match smOperator "\v\="

syntax match smBoolean "\vtrue"
syntax match smBoolean "\vfalse"

syntax match smComment "\v/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+/"

highlight link smKeyword Keyword
highlight link smFunction Function
highlight link smComment Comment
highlight link smBoolean Boolean
highlight link smOperator Operator
