# highlightf90
highlight fortran90 functions and subroutines

# Warning
**a plugin by runoob vimmer**

# depend
- `+python3`

# usage
1. install
``` vim
Plug 'Euler-37/highlight90',{'for':['fortran','plug']}
```
2. It will auto update when the current file saved

# remarks
1. this plugin will generate tags for current files,and append highlight in syntax file
2. if the line of syntax file is bigger than 1000,file will be clean and regenerate.
3. work for `subrotuine,function,interface,generic`
4. may have bugs ,(for windows `$HOME` path)
