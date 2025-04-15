alias lynx="lynx -cfg=~/.config/lynx/lynx.cfg -lss=~/.config/lynx/lynx.lss"

if [ "prefix_$TERM" = "prefix_xterm-ghostty" ]; then
alias clear="TERM=xterm clear"
alias nano="TERM=xterm nano"
alias su="TERM=xterm su"
alias ssh="TERM=xterm ssh"
alias scp="TERM=xterm scp"
fi
