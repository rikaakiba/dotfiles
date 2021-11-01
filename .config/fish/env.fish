# homebrew
if test -x /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
end

# Linux homebrew
if test -x /home/linuxbrew/.linuxbrew/bin/brew
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# Go
command -qv go && set -x PATH (go env GOPATH)/bin $PATH && set -x GOPATH (go env GOPATH)

# Rust (rustup)
if test -d ~/.cargo
  set -x CARGO_HOME $HOME/.cargo
  set -x PATH $CARGO_HOME/bin $PATH
end
