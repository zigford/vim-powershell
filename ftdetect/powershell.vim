" Vim ftdetect plugin file
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Updated:            Jesse Harris <jesse@zigford.org>
" Version:            3.00
" Project Repository: https://github.com/zigford/vim-powershell
" Vim Script Page:    TBA
"
au BufNewFile,BufRead   *.ps1   set ft=powershell
au BufNewFile,BufRead   *.psd1  set ft=powershell
au BufNewFile,BufRead   *.psm1  set ft=powershell
au BufNewFile,BufRead   *.pssc  set ft=powershell
