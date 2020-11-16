# include local scripts
export PATH=$PATH:~/.bin/:~/go/bin

# add Android tools to my path
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# prompt
PROMPT='%1~ %# '

# git prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd() { vcs_info }
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:*' formats '%F{240}(%b) %r %m%c%u%f'
zstyle ':vcs_info:*' actionformats '%F{240}(%b|%a) %r %m%c%u%f'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '*'
# hook to show untracked files, this causes a significant performance hit
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -m 1 '^??' &>/dev/null
  then
    hook_com[misc]='?'
  fi
}

# gitignore.io
function gi() { curl -L -s https://www.gitignore.io/api/$* ;}

# aliases
alias ls='ls -G'
alias ll='ls -lah'
alias git=hub
alias cat=bat
alias weather='curl wttr.in'
alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | sed -E "s/.*inet ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+).*/\1/g"'

# brew autocomplete
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# z
. /usr/local/etc/profile.d/z.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always {}'"
# for path completion (vim file**)
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
# for directory completion (cd folder**)
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

 #nvm
#export NVM_DIR="$HOME/.nvm"
  #[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"   This loads nvm
  #[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"   This loads nvm bash_completion

# rbenv
eval "$(rbenv init -)"
