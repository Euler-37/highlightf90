# highlightf90
highlight fortran90 functions and subroutines

# Warning
**a plugin by runoob vimmer**

# usage
1. install
``` vim
Plug 'Euler-37/highlight90,{'for':['fortran','plug']}'
```
2. and syntax file ,`touch ~/.vim/after/syntax/fortran.vim` or `touch ~/.config/nvim/after/syntax/fortran.vim`
3. It will auto update when the current file saved

# remarks
1. this plugin will generate tags for current files,and append highlight in syntax file
2. if the line of syntax file is bigger than 1000,file will be clean and regenerate.
3. only work for `subroutine` and `function`
4. may have bugs
