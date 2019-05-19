"""this two statements for using system clipboard"""
noremap <Leader>y "*y
noremap <Leader>p "*p
"""
noremap <F3> :Autoformat<CR>
nnoremap <Leader>. :CtrlPTag<cr>

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c,*.py call UpdateTags()

"""set foldmethod=indent
"""set foldlevel=1
"""set foldclose=all
set grepprg=/usr/bin/grep
