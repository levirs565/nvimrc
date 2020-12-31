" For fix copy and remove dir not work when nvim is run under bash windows
if &shell != 'cmd.exe'
    let g:NERDTreeRemoveDirCmd = 'rm -rf '
    let g:NERDTreeCopyDirCmd   = 'cp -r '
    let g:NERDTreeCopyFileCmd  = 'cp -r '
endif
