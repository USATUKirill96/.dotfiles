# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# init zoxide
eval "$(zoxide init zsh)"

# Set threshold to 20seconds
export AUTO_NOTIFY_THRESHOLD=20

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

export EDITOR="nvim"

# Bat aliases. Only use if bat and bat-extras installed
alias bat="batcat"
alias rg="batgrep"
alias fzf="fzf --preview 'batcat --color=always --style=numbers --line-range=:500 {}'"
alias man="batman"

plugins=(git pyenv colored-man-pages zsh-autosuggestions jump sudo virtualenv asdf zsh-syntax-highlighting history-substring-search web-search history $plugins)

source $ZSH/oh-my-zsh.sh

alias myvenv="source venv/bin/activate"
alias mypoetry='source .venv/bin/activate'
alias mydc="docker-compose up -d"
alias myclean='find . -name "*.pyc" -delete'
alias lzd="lazydocker"
alias lzg="~/apps/lazygit/main"
alias arv="python autorv/autorv.py"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/home/aaron/yandex-cloud/path.bash.inc' ]; then source '/home/aaron/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/aaron/yandex-cloud/completion.zsh.inc' ]; then source '/home/aaron/yandex-cloud/completion.zsh.inc'; fi

