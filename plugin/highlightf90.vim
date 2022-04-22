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
    let s:syntax_filepath ='.config/nvim'
else
    let s:syntax_filepath ='.vim'
endif
function! GenerateTags()
:w!
python3<< EOF
import vim
import re
import os
home=os.environ['HOME']
name=vim.eval('expand("%:p")')
filepath=vim.eval('s:syntax_filepath')
filepath = "".join([home,'/',filepath,"/after/syntax"])
path_exist=os.path.exists(filepath)
if not path_exist:
    os.makedirs(filepath)
syntax_file=filepath+"/fortran.vim"
path_exist=os.path.exists(syntax_file)
if not path_exist:
    with open(syntax_file, 'w') as f:
        f.write('syn case ignore\n')
with open(name, 'r') as f:
    input_data=f.read()
functions=re.findall(r'(?i)(?:function|subroutine)\x20+(\w+)\x20*\(',input_data)
functions=list(map(lambda x:x.lower(),functions))
functions=list(dict.fromkeys(functions))
interface=re.findall(r'(?i)(?:interface)\x20+(\w+)',input_data)
interface=list(map(lambda x:x.lower(),interface))
interface=list(dict.fromkeys(interface))
generic  =re.findall(r'(?i)(?:generic|procedure).*::\x20*(\w+)',input_data)
generic  =list(map(lambda x:x.lower(),generic))
generic  =list(dict.fromkeys(generic))
if 'operator' in generic:
    generic.remove('operator')
if 'assignment' in generic:
    generic.remove('assignment')
functions.extend(interface)
functions.extend(generic)
types    =re.findall(r'(?i)(?:type)\x20+(\w+)',input_data)
types    =list(map(lambda x:x.lower(),types))
types    =list(dict.fromkeys(types))
modules  =re.findall(r'(?i)(?:module)\x20+(\w+)',input_data)
modules  =list(map(lambda x:x.lower(),modules))
modules  =list(dict.fromkeys(modules))
if 'procedure' in modules:
    modules.remove('procedure')
with open(syntax_file, 'r') as f:
    existing=f.read()
numoffunction=existing.count('\n')
if(numoffunction>1000):
    with open(syntax_file, 'w') as f:
        f.write('syn case ignore\n')
        for tag in functions:
            f.write('syn keyword UserFunction %s\n' % tag)
        for tag in types:
            f.write('syn keyword UserType %s\n' % tag)
        for tag in modules:
            f.write('syn keyword UserModule %s\n' % tag)
else:
    with open(syntax_file, 'a') as f:
        for tag in functions:
            if re.search(r'(?i)syn keyword .+ %s\s' % tag, existing):
                continue
            f.write('syn keyword UserFunction %s\n' % tag)
        for tag in types:
            if re.search(r'(?i)syn keyword .+ %s\s' % tag, existing):
                continue
            f.write('syn keyword UserType %s\n' % tag)
        for tag in modules:
            if re.search(r'(?i)syn keyword .+ %s\s' % tag, existing):
                continue
            f.write('syn keyword UserModule %s\n' % tag)

EOF
redraw!
:e
endfunction

function! ClearTags()
python3<< EOF
import vim
import re
import os
home=os.environ['HOME']
name=vim.eval('expand("%:p")')
filepath=vim.eval('s:syntax_filepath')
syntax_file = "".join([home,'/',filepath,"/after/syntax/fortran.vim"])
path_exist=os.path.exists(syntax_file)
if path_exist:
    os.remove(syntax_file)
EOF
endfunction

autocmd BufWritePre,FileWritePre *.f90,*.F90,*.f,*.for call GenerateTags()

" vim:set ft=vim sw=4 sts=4 et:
