# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Shell prompt
function git_prompt()
{
    git_branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD 2> /dev/null)
    if [ "$git_branch" != "" ]; then
        if [ $1 -eq 1 ]; then
            git diff-index --quiet --exit-code HEAD
            if [ $? -eq 0 ]; then
                echo "[$git_branch]"
            else
                echo "[$git_branch*]"
            fi
        else
            echo "[$git_branch]"
        fi
    fi
}
PS1='\u($(echo $(pwd) | grep -o "\(^/\)\?\([^/]*/\)\{0,2\}[^/]*$"))$(git_prompt 0)> '

# Shell configuration
set -o notify
set -o noclobber
set -o ignoreeof

shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.

# Command history
if [[ $- = *i* ]] && (( EUID != 0 )); then
	[[ -d ~/.logs ]] || mkdir ~/.logs
	PROMPT_COMMAND='echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log'
fi
alias h='history'
alias srchist='cat ~/.logs/bash-history* | grep -iG --color'

# Git autocomplete
#source ~/.git-completion.bash

# Make nixos pickup apps for gnome app menu
export XDG_DATA_DIRS="~/.nix-profile/share:$XDG_DATA_DIRS"

# Custom aliases
alias u='cd ..'
alias uu='cd ../..'
alias c='clear'
alias q='exit'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias j='jobs -l'
alias ls='ls -Fh --color'
alias sl='ls'
alias ll='ls -Al'
alias ff='find -name "\!*" -type f'
alias fd='find -name "\!*" -type d'
alias df='df -h'
alias du='du -h --max-depth=1'
alias grp='grep -inGHrI --color'
alias g='grp -I \!* .'
alias untar='tar -xvf'
alias mktar='tar -cvf'
alias compd='tar -cvf \!*.tar \!*; gzip \!*.tar'
alias lrg_files='find -regex '"'"'.*/.*\.\(c\|cpp\|h\)$'"'"' -exec wc -l {} \; | sort -k1 -rn | head -10'
alias ref='cd ~/reference/'
alias dl='cd ~/downloads/'
alias cfg='cd ~/config/dotfiles/'
alias dv='cd ~/development/'
alias doc='cd ~/docs/'
alias emb='nix-shell ~/config/embedded-base/shell.nix'

alias winkey='xmodmap -e "keycode 133 = Super_R"'

