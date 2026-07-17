# Automatically run `ls` after `cd` in terminal-attached shells only.
if [[ -t 0 && -t 1 ]]; then
  chpwd() { ls }
fi
