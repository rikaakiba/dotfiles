### Set locale
export LANG=ja_JP.UTF-8
export GPG_TTY=(tty)

### Colorful terminal
export TERM=xterm-256color

### Linux - fcitx5
# set -x GTK_IM_MODULE fcitx5
# set -x QT_IM_MODULE fcitx5
# set -x SDL_IM_MODULE fcitx5
set -x XMODIFIERS "@im=fcitx5"

### Load extra path
[ -e ~/.extra_path ] && cat ~/.extra_path | while read -l pl
  fish_add_path (echo "$pl" | sed -E "s|\~|$HOME|g")
end

### CachyOS
source /usr/share/cachyos-fish-config/cachyos-config.fish

### Load aliases
source ~/.config/fish/alias.fish

### Load plugins
source ~/.config/fish/plugins.fish

### Set vi keybindings
# fish_vi_key_bindings

# Prompt
type -q starship && starship init fish | source

### Fish configs

### Key Bindings
# Bind for peco history to Ctrl+r
function fish_user_key_bindings
  type -q fzf_key_bindings && fzf_key_bindings || bind \cr 'peco_select_history (commandline -b)'
  bind \ck 'peco_kill'
  # fish_vi_key_bindings --no-erase
  bind \ef forward-word
end

fish_user_key_bindings

# Package & Env managers
source ~/.config/fish/env.fish

# Load session env for KDE Plasma
[ -e ~/.config/plasma-workspace/env/env.sh ] && source ~/.config/plasma-workspace/env/env.sh

# Load local configurations
[ -e ~/.config/fish/config.fish.local ] && source ~/.config/fish/config.fish.local

### iTerm2 integration
# test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# function fish_right_prompt --description 'Prints right prompt'
#   if test "$fish_key_bindings" = "fish_vi_key_bindings"
#     prompt_vi_mode
#     set_color normal
#   end
# end
