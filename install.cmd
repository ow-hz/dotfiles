@if not exist "%HOME%" @set HOME=%HOMEDRIVE%%HOMEPATH%
@if not exist "%HOME%" @set HOME=%USERPROFILE%

if not exist "%HOME%\.vim\bundle" (
    call mkdir  "%HOME%\.vim\bundle"
)

call mklink "%HOME\.vimrc" "%HOME%\.dotfiles\vimrc"

if not exist "%HOME%\.vim\bundle\vundle" (
    call git clone https://github.com/gmarik/vundle.git "%HOME%\.vim\bundle\vundle"
) else (
    call cd "%HOME%\.vim\bundle\vundle"
    call git pull
    call cd %HOME%
)

