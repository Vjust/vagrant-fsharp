plugins=(git)

# User configuration export
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/vjust/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions 
if [[ -n $SSH_CONNECTION ]]; then 
   export EDITOR='vim' else export
   EDITOR='emacsclient -nw' 
   export EDITOR
fi

export EDITOR="emacsclient -c"



autoload -U compinit compinit


#typeset -U path path=(~/bin ~/progs/bin $PATH)

DIRSTACKSIZE=9
DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}


setopt autopushd pushdsilent pushdtohome ## Remove duplicate entries
setopt pushdignoredups ## This reverts the +/- operators.  
setopt pushdminus




autoload -U promptinit 
promptinit #prompt adam1 #prompt adam1 gray
setopt INTERACTIVE_COMMENTS 
PS1="%n@%m >" 
PROMPT="%n@%m >"
RPS1="%(?..(%?%)) %~"

#alias ec="TERM=eterm-color;emacsclient "
alias ll='ls -lF' 
alias lla='ls -laF' 
alias la='ls -aF' 
alias ls="ls --color=auto" 
alias lld="ls -1d *"
alias -g L='|less' 
alias -g NUL="> /dev/null 2>&1" 
alias ..='cd ..'  
alias ...='cd ../..'  
alias ....='cd ../../..'  
alias sally='vi ~/.zshrc; source ~/.zshrc; pwd;'


alias tree2='tree -L 2'
alias tree1='tree -L 1'
alias tree3='tree -L 3'
alias treed='find . -maxdepth 3 -type d'
alias apt0='sudo apt-get update'
alias apt1='sudo apt-get install -y'
alias apt9='sudo apt-get upgrade'
alias pippi='pip install'
alias pipf='pip freeze | sort | sed "N;N; s/[==0-9\.]*//g; s/\n/, /g"'
alias tpy='type python;python -V'
alias cdl='cd ..;ll;'
alias mgstat="git status --porcelain | sed -n -e '/^ M\|^??/p'"
alias mgstat2="git status --porcelain | sed -n -e 's/^ M \|^?? //p'"

# uses the find command to search for files
# filename case is ignored  "find -iname .."
# Note: does NOT use wildcards.
function myfind() {

    #echo "myfind $*"
    #echo $PROJECT_ROOT

    if [ "$#" = "0" ]; then
	echo "Usage : myfind <filename> ."
	echo "Usage : myfind <filename> <projectroot> <maxdepth>."	
	return ""
    fi

    if [ "$#" = "1" ]; then
	# invoked as myfind utils.py
	file_spec=$1
	if [ "$PROJECT_ROOT" = "" ]; then
	    project_root="../"
	else
	    project_root=$PROJECT_ROOT
	fi
	
	find $project_root -iname $file_spec|grep -v "env/lib"
    else
	# invoked as myfind utils.py ~/code4 1 (optional 1 being the max depth)
	file_spec=$1
	project_root=$2
	if [ "$#" = "3" ]; then
	    maxdepth=$3
	else
	    maxdepth=2	    
	fi
	echo "here"
	find $project_root -maxdepth $maxdepth -iname $file_spec|grep -v "env/lib"
    fi


}

function pgrepl() {
    
    pgrep -d, $1 | sed -e 's/[^0-9,]//g'
}

function myhtop() {
    procs=""
    for i in $*
    do
        procs="$(pgrepl $i),$procs"
    done
    htop -p $procs
}


# the dofi option will search out the file under project root and commit it.
function mygit() {
    arg1=$1
    arg2=$2
    
    if [ "$#" = "0" ]; then
	echo "Usage: mygit <ig:ignore/st:status/do:add&commit/pu:add-commit-push/dofi:add&commit a file> <comment>"
    fi

    if [ "$arg1" = "st" ]; then
	mgstat2
    fi
    
    if [ "$arg1" = "ig" ]; then	
	for i in $*
	do
	    echo $i >> ./.gitignore
	done
	more .gitignore
    fi

    #echo "here1 $arg1 $arg2"

    if [ "$arg1" = "do" ]; then
	comment=$arg2
	mgstat2
	echo "press any key to continuue"
	read x
	git add $(mgstat2)
	git commit -m $comment
    fi

    # this option add+commit only 1 specific file
    if [ "$arg1" = "dofi" ]; then
	echo "dofi"
	fispec=$arg2
	comment=$arg3
	files=$(myfind $fispec)
	echo "press any key to continue \nFiles: $files "
	read x
	git add $files
	git commit -m $comment $files
    fi
    

    if [ "$arg1" = "pu" ]; then
	comment=$arg2
	mgstat2
	echo "press any key to continuue"
	read x
	git add $(mgstat2)
	git commit -m $comment
	git push origin master
    fi

}



    
    
# does a case insensitive search for a file
# superseeded by myfind
function filefilter() {
    if [ "$#" = "0" ]; then
	return ""
    fi

    if [ "$#" = "1" ]; then
	file_type="source"
	file_spec=$1
    else
	file_spec=$1
	file_type=$2
    fi    
    
    if [ "$FILE_LIST" = "" ] ; then
	file_list="tmp/project_file_list"
    fi

    res=""
    if [ "$file_type" = "source" ]; then	
	cat $file_list|grep -i $file_spec |grep -v "\(pyc\|gz\)"
    else
	cat $file_list|grep -i $file_spec|grep "$file_type"
    fi
}


# ~~~~~~~~~~~~~~~~~~~~~ Project specific shortcuts ~~~~~~~~~~~~~~~~ 

#~~~~~~~~~~~~~~~~~~~~~~~~~~~ end shortcuts ~~~~~~~~~~~~~~~~~~~~~~~~~


setopt AUTO_CD

HISTSIZE=1000 
SAVEHIST=1000
HISTFILE=~/.zsh_history 
set histchars='@^#' 
setopt hist_verify 
setopt share_history 
setopt inc_append_history 
setopt hist_ignore_all_dups 
setopt hist_find_no_dups 
setopt hist_reduce_blanks


#globbing setopt extended_glob


# app-specifi settings 

alias mytree="tree | grep -v '\.[a-z][a-z]' | grep -v '[A-Z][A-Z][A-Z]'"

alias venv="source env/bin/activate" 
alias denv="deactivate" 
alias emac="emacsclient -c &" 
alias emas="emacs --daemon; emac" 
alias pgrep='pgrep -fl' 
alias tatt='tmux attach-session -t' 
alias tlis='tmux list-sessions ' 
alias tkil='tmux kill-server'
alias tnew='tmux new-session -s' 
alias mtree='tree | grep -v '\.  
alias curlo='curl -o -' 
alias gd1='cd;ssh sjac-dev1'
alias gp1="cd;ssh pilot-1" 
alias gpcl="cd;ssh pilot-1-clone"

alias up8='sudo apt-get update' 
alias up8i='sudo apt-get install -y'
alias keecp='scp ~/.ssh/id_rsa.pub' 
alias pych="/home/vjust/Desktop/pycharm/bin/pycharm.sh &" 
alias gitbitunch="git update-index --assume-unchanged" 
alias gitbitch="git update-index --no-assume-unchanged" 
alias hbar='pushd .; cd ~coo/static/js; grunt handlebars;popd'
alias muxcoo='cd ~;tlux ~coo ~coo/env tmux_corr.conf'   
alias tummy="tmux -f ~/tmux_local_serv.conf attach"
alias tumpy3="tmux -f ~/tmux_ipy3.conf attach"
alias owget="wget -q -O - "
alias owg1278="wget -q -O - 127.0.0.1:8000"
alias owg127="wget -q -O - 127.0.0.1"


# ipython related
alias ipyprofiles="ls ~/.ipython/ | sed -n 's/profile_//p'"  
function gitcl() { git clone git@github.com:$1 }


#~~~~~~~~~~~~~~~~~~~~~~ custom functions -----------------# func
glup() { patt=$1; shift; cmd=($*); $cmd | grep $args "$patt" | more }


function sally2()
{
vi +/$1 ~/.zshrc; source ~/.zshrc; pwd;
}

function goshconf()
{
    vi +/$1 ~/.ssh/config
}


# if there's a manage.py run it
# else use the first arg
function ppr() {

   file=$(ls -1 *.py)
   file_count=$(ls -1 *.py|wc -l)
   echo $file
   echo $file_count
   if test -f manage.py ; then
	if test "$1" -eq "" ; then
	   manage.py runserver
	   return
        else
           manage.py $1
	   return
        fi
   elif test "$file_count" -eq "1"; then
        file=$(ls -1 *.py)
	python $file runserver
        return
   else
	spec=$1
	files=$(ls -1 $spec*.py)
	python $files runserver
	return
   fi

}

getvenvdir () {

  # look for a specific dir in this , or parent.
  if test "$1" != "" ; then
     if test -d "$1" ; then
	echo $1
        return
     elif test -d "../$1"; then
	echo "../$1"
	return
     else
        echo ""
        return
     fi
  fi

  # no args, so we look for *env*
  envdir=$(ls -1d *|grep env)
  countdir=$(ls -1d *|grep env|wc -l)

  if test "$countdir" -eq "0" ; then
	# look in the parent dir
        envdir=$(ls -1d ../*|grep env)
	countdir=$(ls -1d ../*|grep env|wc -l)
        if test "$countdir" -eq "1" ; then
		echo $envdir
		return
        else
		echo ""
		return
        fi 
  elif test "$countdir" -eq "1"; then
       echo $envdir
       return
  else 
       echo ""
       return
  fi
}

# if there's a unique *env* folder, activate it
# else use the first arg
ffenv() 
{ 

    envdir=$(getvenvdir $@) 

    if test "$envdir" = ""; then 
	   echo "No env found"
	   echo "Envdir:" $envdir
	   return
    fi
	
    source $envdir/bin/activate
    type python 
    python -V
    pipf
    return
}

# makes a temp alias, right here+right now
function ffnn() {
    alias nn="cd $(pwd); $1"
    alias nn
}

#grep my environment
function malia() { 
    args=$1; 
    if [[ "$args" == "" ]]; then 
	args="."
        alias | grep -i $args; 
	hash -d | grep -i $args 
    else 
	env | grep -i $args; 
	alias | grep -i $args; 
	hash -d | grep -i $args;
	grep -i $args ~/.zshrc
    fi; 
}

#git clone
function gclone() { 
    user=$1 
    project=$2.git 
    git clone git@github.com:${user}/${project} 
}

#ssh tunnelling
function ipnbssh() { 
    port1=$1; 
    port2=$2; 
    hostname=$3; 
    echo "ssh -N -f -L localhost:${1}:localhost:${2} ${hostname}"; 
    ssh -N -f -L localhost:${port1}:localhost:${port2} ${hostname} 
}


#git add
function gfast() { 
    if [[ ! -d ".git" ]]; then 
	echo "Not a git dir"
	return -1 
    fi;

    if [[ $# == 0 ]]; then 
	echo "Usage gfast <message>" 
    else
        message=$1 
	git add . && git commit -m $1 && git push 
    fi 
}

#tree command
function tre() {
    args=$*
    if [[ "$args" == "" ]]; then
	tree 
    else
	tree -L $args
    fi
}


#get a random #
function get_rand()
{
    h=$(perl -e '$k=rand; $j=sprintf ("%.0f\n", $k * 10000); print $j')
    echo $h
}

function tlux()
{
    # usage : tlux proj1_dir proj1_dir/env
    # will create a session called proj1_dir, and execute the virtualenv
    #tmux list-session
    if [ $# = 0 ] ;
    then
	echo "usage tlux proj1_dir [env_dir] [tmux startup file]"
	return -1
    fi
    export homedir=$1
    export sessname=$(basename $homedir)
    if [ $# = 2 ] ; then
	export venv=$2
    else
	export venv=""
    fi
    export startup="~/.tmux.conf"
    if [ $# = 3 ]; then
	export startup=$3
    fi

    if ! tmux has-session -t $sessname 2>/dev/null; then
	echo "Creating new session home: ${homedir}, sess:${sessname}, venv:${venv}" 
	read
	tmux new-session -c $homedir -s $sessname -n aa -d  
	if [ $# = 3 ]; then
	   # startup is a file containing customized tmux session commands
	   # for each virtual env
	   zsh $startup
	fi
    else
	echo "attaching to an existing session $sessname"
	read
    fi	
    tmux attach -t $sessname
}



EDITOR='emacsclient -c'



function sling()
{
    mkdir -p ~/.sling
    cmd=$1
    shift
    comments="$*"
    if [ "$cmd" = "hist" ]
    then
	tail ~/.sling/history
	return
    fi
    echo $comments
    echo "Cmd: $cmd" "," "Loc: $(pwd)" "," "Desc: $comments" >> ~/.sling/history
    alias shot="$cmd"

    # if comments are specified then we will not execute.
    
    if [ "$#" -eq 0 ]
    then
	echo "alias shot=$(alias shot). Press key to launch"
	read x
        shot
    fi
}

