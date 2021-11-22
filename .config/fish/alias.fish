# abbreviations
abbr -a g git
abbr -a k kubectl

# Replace apps with better alternatives
type -q exa && alias ls=exa
type -q rg && alias grep=rg

# bat is installed as "batcat" on debian distros, create a symlink for consistency
if not type -q bat and type -q batcat
  ln -sfn (which batcat) ~/.local/bin/bat
end

# Replace vim with neovim if possible
# Also set default editor to neovim
type -q nvim && alias vim=nvim && set EDITOR /usr/bin/nvim

# Always run virsh with --connect qemu:///system
type -q virsh && alias virsh="virsh --connect qemu:///system"
