
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

# fix ctrl forward historysearch
# http://stackoverflow.com/questions/791765/unable-to-forward-search-bash-history-similarly-as-with-ctrl-r
stty -ixon
