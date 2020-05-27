alias ll='ls -alF'
alias lh='ls -alFh'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias gitlog='git log --oneline --graph --decorate --all'

export PS1="\u@\h \W \$ " # original promt was \h:\W \u\$
export CLICOLOR=1 # colors in ls
export EDITOR='emacs -nw'
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home"
# export PATH=$JAVA_HOME/bin:$PATH

# following line is for autojump; see https://stackoverflow.com/a/31442634/162684
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# for git bash_completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
alias ic="ibmcloud"
