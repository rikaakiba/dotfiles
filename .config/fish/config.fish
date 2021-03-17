### Set locale
export LANG=ja_JP.UTF-8
export GPG_TTY=(tty)

### Colorful terminal
export TERM=xterm-256color

### Load extra path
[ -e ~/.extra_path ] && cat ~/.extra_path | while read -l pl
  set -g fish_user_paths (echo "$pl" | sed -E "s|\~|$HOME|g") $fish_user_paths
end

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
  bind \cr 'peco_select_history (commandline -b)'
  bind \ck 'peco_kill'
  # fish_vi_key_bindings --no-erase
end

fish_user_key_bindings

# Package & Env managers
source ~/.config/fish/env.fish

### iTerm2 integration
# test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# function fish_right_prompt --description 'Prints right prompt'
#   if test "$fish_key_bindings" = "fish_vi_key_bindings"
#     prompt_vi_mode
#     set_color normal
#   end
# end
