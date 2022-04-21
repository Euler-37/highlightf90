# highlightf90
highlight fortran90 functions , subroutines , types ,modules

# Warning
**a plugin by runoob vimmer**

# depend
- `+python3`

# usage
1. install
``` vim
Plug 'Euler-37/highlight90',{'for':['fortran','plug']}
```
2. config
``` vim
autocmd BufEnter *.f90,*.f,*.for,*.F90 hi UserFunction guifg=#ddff00
autocmd BufEnter *.f90,*.f,*.for,*.F90 hi UserType guifg=#21e7e1 gui=italic
autocmd BufEnter *.f90,*.f,*.for,*.F90 hi UserModule guifg=#f89860 gui=italic 
```
3. It will auto update when the current file saved
4. If want to clear syntax file just run `:call ClearTags()`



# remarks
1. this plugin will generate tags for current files,and append highlight in syntax file
2. if the line of syntax file is bigger than 1000,file will be clean and regenerate.
3. work for `subrotuine,function,interface,generic,type,module`,not support for `type :: bar`,suggest using  `end type bar` not `end type`
4. may have bugs ,(for windows `$HOME` path)
