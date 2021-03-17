# Linux homebrew
if test -x /home/linuxbrew/.linuxbrew/bin/brew
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# Go
if [ ! -z (command -v go) ]
  set -x PATH (go env GOPATH)/bin $PATH
  set -x GOPATH (go env GOPATH)
end
