# homebrew
if test -x /opt/homebrew/bin/brew
  eval (/opt/homebrew/bin/brew shellenv)
  if test -x /usr/local/bin/brew
    alias ibrew="arch -x86_64 /usr/local/bin/brew"
  end
end

# Linux homebrew
if test -x /home/linuxbrew/.linuxbrew/bin/brew
  eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# Go
command -qv go && fish_add_path (go env GOPATH)/bin && set -x GOPATH (go env GOPATH)

# Rust (rustup)
if test -d ~/.cargo
  set -x CARGO_HOME $HOME/.cargo
  fish_add_path $CARGO_HOME/bin
end

# pyenv
if command -qv pyenv
  set -Ux PYENV_ROOT $HOME/.pyenv
  fish_add_path $PYENV_ROOT/bin
  status is-login; and pyenv init --path | source
  status is-interactive; and pyenv init - | source
end

# Volta(node)
if command -qv volta
  set -x VOLTA_HOME "$HOME/.volta"
  set -x PATH "$VOLTA_HOME/bin" $PATH
end

