# Replace apps with better alternatives
type -q exa && alias ls=exa
type -q rg && alias grep=rg

# bat is installed as "batcat" on debian distros, create a symlink for consistency
if not type -q bat and type -q batcat
  ln -sfn (which batcat) ~/.local/bin/bat
end

# Replace vim with neovim if possible
type -q nvim && alias vim=nvim
