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
alias slack='slack-cli'
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

# transfer.sh
# same as curl --upload-file ./hello.txt https://transfer.sh/hello.txt
transfer() {
  if [ $# -eq 0 ];
  then echo -e "No arguments specified. Usage:\\ntransfer file.md";
    return 1;
  fi
  tmpfile=$( mktemp -t transferXXX );
  if tty -s;
  then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> "$tmpfile";
  else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> "$tmpfile" ;
  fi
  cat "$tmpfile";
  rm -f "$tmpfile";
}

# file.io
# same as curl -F "file=@test.txt" https://file.io
share() {
  if [ $# -eq 0 ];
  then echo -e "No arguments specified. Usage:\\nshare file.md";
    return 1;
  fi
  curl -F "file=@$1" https://file.io
}
# same as curl -F "text=this is some text" https://file.io
sharetext() {
  if [ $# -eq 0 ];
  then echo -e "No arguments specified. Usage:\\nshare \"some text\"";
    return 1;
  fi
  curl -F "text=$1" https://file.io
}

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

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#autoload -U add-zsh-hook
#load-nvmrc() {
  #if [[ -f .nvmrc && -r .nvmrc ]]; then
    #nvm use
  #elif [[ $(nvm version) != $(nvm version default)  ]]; then
    #echo "Reverting to nvm default version"
    #nvm use default
  #fi
#}
#add-zsh-hook chpwd load-nvmrc
#load-nvmrc

# rbenv
eval "$(rbenv init -)"
