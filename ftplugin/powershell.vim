" Vim filetype plugin file
if &compatible || exists('g:loaded_powershell')
    finish
endif

function! s:powershell()
    
endfunction!

let g:loaded_powershell = 1
" Language:           Windows PowerShell
" Maintainer:         Peter Provost <peter@provost.org>
" Updated:            Jesse Harris <jesse@zigford.org>
" Version:            3.00
" Project Repository: https://github.com/zigford/vim-powershell
" Vim Script Page:    TBA
"

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin") | finish | endif

" Don't load another plug-in for this buffer
let b:did_ftplugin = 1

setlocal tw=0
setlocal commentstring=#%s
setlocal formatoptions=tcqro
" Enable autocompletion of hyphenated PowerShell commands,
" e.g. Get-Content or Get-ADUser
setlocal iskeyword+=-

" Change the browse dialog on Win32 to show mainly PowerShell-related files
if has("gui_win32")
	let b:browsefilter =
				\ "All PowerShell Files (*.ps1, *.psd1, *.psm1, *.ps1xml)\t*.ps1;*.psd1;*.psm1;*.ps1xml\n" .
				\ "PowerShell Script Files (*.ps1)\t*.ps1\n" .
				\ "PowerShell Module Files (*.psd1, *.psm1)\t*.psd1;*.psm1\n" .
				\ "PowerShell XML Files (*.ps1xml)\t*.ps1xml\n" .
				\ "All Files (*.*)\t*.*\n"
endif

" Look up keywords by Get-Help:
" check for PowerShell Core in Windows, Linux or MacOS
if executable('pwsh') | let s:pwsh_cmd = 'pwsh'
" on Windows Subsystem for Linux, check for PowerShell Core in Windows
elseif exists('$WSLENV') && executable('pwsh.exe') | let s:pwsh_cmd = 'pwsh.exe'
" check for PowerShell <= 5.1 in Windows
elseif executable('powershell.exe') | let s:pwsh_cmd = 'powershell.exe'
endif

if exists('s:pwsh_cmd')
  if !has('gui_running') && executable('less')
    command! -buffer -nargs=1 GetHelp silent exe '!' . s:pwsh_cmd . ' -NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command Get-Help -Full "<args>" | ' . (has('unix') ? 'LESS= less' : 'less') | redraw!
    setlocal keywordprg=:GetHelp
  else
    let &l:keywordprg = (has('terminal') ? ':term ' : '') . s:pwsh_cmd . ' -NoLogo -NoProfile -NonInteractive -ExecutionPolicy RemoteSigned -Command Get-Help -Full'
  endif
endif

" Undo the stuff we changed
let b:undo_ftplugin = "setlocal tw< cms< fo< iskeyword< keywordprg<" .
			\ " | unlet! b:browsefilter"

