" Vim filetype plugin
" Language:   stylus 
" Author:     Naoyuki ABE <plasticscafe@gmail.com>
" Last Change: 2012 Jun 19
echo 'hogeoge'
if !exists('g:stylus_autocompile')
  let g:stylus_autocompile = 0 
endif
if !exists('g:stylus_compress')
  let g:stylus_compress = 0
endif
if system('which stylus') != ''
autocmd BufWritePost,BufEnter *.styl call s:auto_stylus_compile()
function! s:auto_stylus_compile() " {{{
if g:stylus_compress != 0 
  let compress_option = ' -c '
else
  let compress_option = ' '
endif
if g:stylus_autocompile != 0
  try
    let css_name = expand("%:r") . ".css"  
    let stylus_name = expand("%")  
    if filereadable(css_name) || 0 < getfsize(stylus_name)
      silent execute ':!stylus ' . compress_option . stylus_name . ' 1> /dev/null 2>&1' 
      let stylus_date = system('date -r ' . stylus_name . ' +%s') 
      let css_date = system('date -r ' . css_name . ' +%s') 
      if !filereadable(css_name) || css_date < stylus_date
        highlight StatusLine ctermfg=Red
      else
        highlight StatusLine ctermfg=none 
      endif
    endif
  endtry
endif
endfunction " }}}
endif
