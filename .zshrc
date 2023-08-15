#====================================================================
# Name = Ztools
# Created by = Diego Cesare <diegocesare300491@gmail.com>
# Insimpled by = Oh My Zsh
# Functions = Make the use of the terminal with zsh
# more friendly and aesthetically
# more beautiful and functional.
# Dependencies = fzf, pacman-contrib
# Optional facilities = zsh-syntax-highlighting, zsh-autosuggestions
#====================================================================

# Uncomment to select a theme for the prompt
# Restart terminal or zsh with "zsh"
# command in terminal
#===========================================
# commun.zsh
# line.zsh
# simple.zsh
# mirosmar.zsh
# powerone.zsh
# torva.zsh
# lollipop-mint.zsh

export ZSH="$HOME/.oh-my-zsh/"
export PATH=$PATH:$HOME/.local/bin

# Add Fig integration
[ -s ~/.fig/shell.pre ] && source ~/.fig/shell.pre


Theme="torva.zsh"

# Use tmux
#[[ $- != *i* ]] && return
#[[ $TERM != screen* ]] && exec tmux -2

export UPDATE_ZSH_DAYS=2

# Use to install packages
# The packages will be displayed on the screen,
# showing the package information focused on the right side,
# and will also be displayed if the package is installed.
# You can use the keyboard to navigate through the options and also search for a specific package.

# Source plugins
plugins=(
  git
)


source ~/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
source ~/.oh-my-zsh/plugins/sudo/sudo.plugin.zsh
source ~/.oh-my-zsh/plugins/you-should-use/you-should-use.plugin.zsh

# Functions
source ~/.oh-my-zsh/functions.zsh
# Source prompt themes
source ~/.oh-my-zsh/themes/${Theme}
# Use aliases
source ~/.oh-my-zsh/alias.zsh


# Set prompt
#===========
unsetopt ALL_EXPORT
setopt PROMPT_SUBST

# Set/unset ZSH options
#======================
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
unsetopt BG_NICE
setopt CORRECT
setopt EXTENDED_HISTORY

# Setopt HASH_CMDS
#=================
setopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset shell options
#=========================
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

setopt autocd        # Automatically cd into typed directory.
stty stop undef        # Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Autoload zsh modules when they are referenced
#==============================================
autoload -U history-search-end
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof

#zmodload -ap zsh/mapfile mapfile
#================================
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

# Set variables
#==============
PATH="/usr/local/bin:/usr/local/sbin/:$PATH"
# Enable command history
HISTFILE=~/.zsh_history
HISTSIZE=10000000
SAVEHIST=10000000
setopt histignorealldups # Ignore duplicates in history
setopt HIST_IGNORE_SPACE # Ignore commands that begin with a space in history
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';

# Load simple
#============
autoload simple zsh/terminfo
if [[ "$terminfo[simple]" -ge 8 ]]; then
   simple
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE PURPLE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
done

# Completion Styles
#==================
autoload -U compinit
compinit

zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-simple ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# list of completers to use
#==========================
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
#==========================================================================
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
#===========================================
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
#========================
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
#===============================
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
#==============================================
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details, and host completion
# on processes completion complete all user processes
#=============================================================================
zstyle ':completion:*:processes' command 'ps -au$USER'

# add simple to processes for kill completion
#============================================
zstyle ':completion:*:*:kill:*:processes' list-simple '=(#b) #([0-9]#)*=0=01;31'

# NEW completion:
#================
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts \
| grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')

# Filename suffixes to ignore during completion (except after rm command)
#=========================================================================
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
'*?.old' '*?.pro'

# ignore completion functions (until the _ignored completer)
#===========================================================
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort

# SSH Completion
#===============
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

# History beginning search
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward
bindkey '^[[1;2A' up-line-or-history
bindkey '^[[1;2B' down-line-or-history
bindkey -a '^[[A' history-beginning-search-backward
bindkey -a '^[[B' history-beginning-search-forward
bindkey -a 'k' history-beginning-search-backward
bindkey -a 'j' history-beginning-search-forward
bindkey -a 'K' vi-up-line-or-history
bindkey -a 'J' vi-down-line-or-history

bindkey '^[[3~' delete-char; bindkey -a '^[[3~' delete-char # Make delete key work as expected

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Save path on cd
function cd {
    builtin cd $@
    pwd > ~/.last_dir
}

# Restore last saved path
if [ -f ~/.last_dir ]
    then cd `cat ~/.last_dir`
fi

# Show path content
# exa -1 --icons

# Print Pokemon (random)
pokemonshow --xterm

# [ -f "/home/silcniu/.ghcup/env" ] && source "/home/silcniu/.ghcup/env" # ghcup-env


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
