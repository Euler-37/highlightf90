" highlightf90.vim
" Author:      Euler-37
" Version:      0.0.1
"
"----------------------------------------------"
" highlight fortran 90 functions and subroutines
"----------------------------------------------"
if exists("g:loaded_highlightf90") || &cp || v:version < 700
  finish
endif
let g:loaded_highlightf90 = 1
if has('nvim')
    let g:syntax_filepath ='.config/nvim'
else
    let g:syntax_filepath ='.vim'
endif
function! GenerateTags()
:w!
python3<< EOF
import vim
import re
import os
home=os.environ['HOME']
name=vim.eval('expand("%:p")')
syntax_file=vim.eval('g:syntax_filepath')
syntax_file = "".join([home,'/',syntax_file,"/after/syntax/fortran.vim"])
print(syntax_file)
with open(name, 'r') as f:
    input_data=f.read()
functions= re.findall(r'(?i)(?:function|subroutine)\s+(\w*)\s*\(',input_data, re.DOTALL)
functions=list(dict.fromkeys(functions))
with open(syntax_file, 'r') as f:
    existing=f.read()
numoffunction=existing.count('\n')
if(numoffunction>1000):
    with open(syntax_file, 'w') as f:
        f.write('syn case ingore\n')
        for tag in functions:
            f.write('syn keyword function %s\n' % tag)
else:
    with open(syntax_file, 'a') as f:
        for tag in functions:
            if re.search(r'(?i)syn keyword .+ %s\s' % tag, existing):
                continue
            f.write('syn keyword function %s\n' % tag)

EOF
redraw!
:e
endfunction
autocmd BufWritePre,FileWritePre *.f90 call GenerateTags()

" vim:set ft=vim sw=4 sts=4 et:
