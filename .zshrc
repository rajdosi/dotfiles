# https://medium.com/@oldwestaction/beautifying-your-terminal-with-zsh-prezto-powerlevel9k-9e8de2023046

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Auto suggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=243"

# colorls
source $(dirname $(gem which colorls))/tab_complete.sh
alias lc="colorls"

# Configurations - https://github.com/bhilburn/powerlevel9k/wiki/Show-Off-Your-Config
# https://github.com/bhilburn/powerlevel9k/wiki/Show-Off-Your-Config#falkors-configuration
# https://github.com/bhilburn/powerlevel9k/wiki/Show-Off-Your-Config#sudhindras-config

# Common settings - https://github.com/bhilburn/powerlevel9k
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

# Prefixes and separators for prompts lines
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{014}\u256D"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f"

# Info on left and right side of terminal
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir_writable dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv anaconda disk_usage time ram custom_wifi_signal)

# icons - https://framagit.org/phineas0fog/dotfiles/blob/51385cb0d9ff4b244ecd0293a49c189b1352c1c4/custom/themes/powerlevel9k/functions/icons.zsh
OS_ICON="\uf302"
POWERLEVEL9K_HOME_ICON="\uf015"
POWERLEVEL9K_HOME_SUB_ICON="\uf015"
POWERLEVEL9K_FOLDER_ICON="\uf752"
POWERLEVEL9K_DISK_ICON="\uf0a0"
POWERLEVEL9K_RAM_ICON="\uf0e4"
POWERLEVEL9K_VCS_GIT_ICON="\uf408"
POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\uf408"
POWERLEVEL9K_VCS_UNTRACKED_ICON="\uf540"

# OS settings
POWERLEVEL9K_OS_ICON_BACKGROUND="black"
POWERLEVEL9K_OS_ICON_FOREGROUND="white"

# Username and hostname context
POWERLEVEL9K_CONTEXT_TEMPLATE="%n@%m"
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="214"
POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="24"

# Writable dir settings
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="214"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="6"

# Directory truncation settings
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_unique"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1

# Directory settings
POWERLEVEL9K_DIR_HOME_BACKGROUND="38"
POWERLEVEL9K_DIR_HOME_FOREGROUND="black"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="38"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="black"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="38"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="black"

# VCS settings
POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=false
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=7
POWERLEVEL9K_VCS_CLEAN_BACKGROUND="35"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="yellow"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="214"

# Wifi settings
zsh_wifi_signal(){
        local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I)
        local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

        if [ "$airport" = "Off" ]; then
                local color='%F{grey}'
                echo -n "%{$color%}Wifi Off"
        else
                local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
                local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
                local color='%F{black}'

                echo -n "%{$color%}$speed Mbps \uf1eb%{%f%}"
        fi
}
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="white"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="black"

# Ram settings
POWERLEVEL9K_RAM_BACKGROUND="38"

# Time settings
POWERLEVEL9K_TIME_BACKGROUND="white"
POWERLEVEL9K_TIME_FOREGROUND="black"
POWERLEVEL9K_TIME_FORMAT="%D{\uf017 %H:%M:%S \uf073 %d/%m}"

# HDD usage settings
POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND="black"
POWERLEVEL9K_DISK_USAGE_NORMAL_BACKGROUND="35"
POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND="black"
POWERLEVEL9K_DISK_USAGE_WARNING_BACKGROUND="yellow"
POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND="black"
POWERLEVEL9K_DISK_USAGE_CRITICAL_BACKGROUND="214"

# Command status settings
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"

autoload -Uz compinit && compinit

# Customize to your needs...
export PATH=$PATH:/usr/local/bin/
export PATH=$PATH:~/bin

alias ccat="pygmentize -g"

alias sshc='ssh -o ProxyCommand=none'

alias sz='source ~/.zshrc'

precmd() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

checkglobalizedvip() {
  (nslookup $1-$2.$2.proxy.amazon.com &&
  nslookup $1-$2.$2.x-region.amazon.com &&
  host $1-$2.$2.proxy.amazon.com &&
  host $1-$2.$2.x-region.amazon.com &&
  echo GLOBALIZED VIP CHECKS PASS) ||
    echo LAST GLOBALIZED VIP CHECK FAILED

  echo THE FOLLOWING WILL ONLY PASS IF SCRIPT IS RUN INSIDE THE HOST REGION
  host $1.$2.amazon.com
}
export JAVA_TOOLS_OPTIONS="-Dlog4j2.formatMsgNoLookups=true"
