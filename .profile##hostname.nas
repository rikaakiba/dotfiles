if [ ! -z "$(uname -a | grep synology)" ]; then
  [ -x "$(command -v fish)" ] && exec fish "$@"
fi
