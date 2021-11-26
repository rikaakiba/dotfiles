
# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/

########################################

# Load plugins
plugins=(git ssh-agent)

# 環境変数
export LANG=ja_JP.UTF-8
export DYLD_LIBRARY_PATH=/usr/local/opt/openssl/lib:$DYLD_LIBRARY_PATH
# Load session env for KDE Plasma
[ -e ~/.config/plasma-workspace/env/env.sh ] && source ~/.config/plasma-workspace/env/env.sh
source ~/.environment

# Load extra paths
for EXTRA_PATH in $(<~/.extra_path); do
  export PATH=$EXTRA_PATH:$PATH
done

# zsh-completions の設定
fpath=(/usr/local/share/zsh-completions $fpath)

# 色を使用出来るようにする
autoload -Uz colors
colors

# vi風キーバインドにする
bindkey -v

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# Report time for commands running longer than 3 seconds
REPORTTIME=3
TIMEFMT='
total  %E
user   %U
system %S
CPU    %P
cmd    %J'

# プロンプト
# 1行表示
PROMPT="%{${fg[green]}%}[%n@%m@zsh]%{${reset_color}%} %~ %# "
# 2行表示
# PROMPT="%{${fg[green]}%}[%n@%m]%{${reset_color}%} %~
# %# "


# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# 補完機能を有効にする
autoload -Uz compinit
compinit -u

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'


########################################
# vcs_info
autoload -Uz vcs_info
# autoload -Uz add-zsh-hook
setopt prompt_subst

# gitのチェックを有効にする
zstyle ":vcs_info:*" enable git
# commitしていない変更をチェックする
zstyle ":vcs_info:git:*" check-for-changes true
# gitリポジトリに対して、変更情報とリポジトリ情報を表示する
zstyle ":vcs_info:git:*" formats "⭠ %r ⮁ %b%u%c"
# gitリポジトリに対して、コンフリクトなどの情報を表示する
zstyle ":vcs_info:git:*" actionformats "⭠ %r ⮁ %b%u%c ⮁ %a"
# addしていない変更があることを示す文字列
zstyle ":vcs_info:git:*" unstagedstr " ⮁ Unstaged"
# commitしていないstageがあることを示す文字列
zstyle ":vcs_info:git:*" stagedstr " ⮁ Staged"
# zstyle ':vcs_info:*' formats '%F{green}(%s)-[%b]%f'
# zstyle ':vcs_info:*' actionformats '%F{red}(%s)-[%b|%a]%f'
#
precmd () { vcs_info }
RPROMPT=$RPROMPT'${vcs_info_msg_0_}'

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
# setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

setopt +o nomatch
########################################
# キーバインド

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -al'
alias lal='ls -al'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'
alias dirs='dirs -v'

if command -v nvim > /dev/null; then
    alias vim='nvim'
fi

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

########################################
# OS 別の設定
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

# volta:  https://volta.sh/
# volta completions zsh > /usr/local/share/zsh/site-functions/_volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH":

# iTerm2 Integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# jenv
test -e "$HOME/.jenv" && export PATH="$HOME/.jenv/bin:$PATH"

# Local configuration
if ! test -e "$HOME/.zshrc.local"; then
    # Powerline
    # powerline-daemon called in .zprofile
    POWERLINE_PACKAGE_INFO=$(pip3 show powerline-status 2>/dev/null) 
    if [ $? -eq 0 ]; then
        POWERLINE_SCRIPT_PATH=$(echo ${POWERLINE_PACKAGE_INFO} | grep Location | sed -E "s/^Location: (.+)$/\1/g")
        echo "${POWERLINE_SCRIPT_PATH}/powerline/bindings/zsh/powerline.zsh" > ~/.zshrc.local
    fi
fi

if [ -e ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi


# zprof
# if (which zprof > /dev/null) ;then
#   zprof | less
# fi


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node

### End of Zinit's installer chunk
zinit light qoomon/zsh-lazyload

# lazyload stuff
lazyload jenv -- 'jenv init -'
if type kubectl >/dev/null 2>&1; then
  kubectl () {
    unset -f kubectl
    # lazy load
    source <(kubectl completion ${SHELL##*/})
    kubectl "$@"
  }
fi

# Syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
