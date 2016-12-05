# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gitster"

EDITOR="atom"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(cask docker docker-compose fasd git node osx xcode)

# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa"

# fasd
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias j='fasd_cd -d'     # cd, same functionality as j in autojump
alias z='fasd_cd -d -i' # cd with interactive selection

alias "c."='$EDITOR .'
alias "a."='$EDITOR .'

alias dps='docker ps --format "table {{.ID}}\t{{.Command}}\t{{.Names}}\t{{.Ports}}"'
alias pup="pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
alias reset-dock='defaults delete com.apple.dock; killall Dock'
alias reset-launchpad='defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock'

# A better Docker attach
attach() {
	if [ ! $1 ];
		then
			echo "A container must be selected";
	elif [ ! $2 ];
		then
			docker exec -i -t $1 /bin/bash -c "export TERM=xterm; exec bash";
	else
			docker exec -i -t $1 $2;
	fi
}

# Everything must go! Except the cow, the cow can stay ...
cls() {
	clear;
	greeting;
}

# Coffee. Must ... Stay ... Awake ...
coffee() {
  if [ ! $1 ];
    then
      caffeinate;
  elif [ $1 = "wait" ];
    then
      caffeinate -d $2;
  elif [ $1 = "time" ];
    then
      caffeinate -t $2;
  fi
}

# Refreshing Docker Machine status
docker-watch() {
	while :
		do
	  	clear;
			dps;
			sleep 2;
	done
}

# Cow says Hello
greeting() {
	lang=fr;
	greeting=$(trans :${lang} --brief "hello");
  user=$(whoami);
  time=$(date '+%X');
	quote=$(fortune -sn 40);
  echo -e "${greeting} ${user}, the time is: ${time}\n" "${quote}" | cowthink | lolcat;
}

# Alias NOM to NPM, for fun and profit
nom() {
  npm "$@";
}

select-language() {
	list=$( trans -reference | while read line; do echo $(cat $1); done | tr '|' '\n');
	languages=( $list );

	for var in "${languages[@]}"
	do
		lang=${var}
		test=$lang | perl -ne 'print "$1" if /(.*)\s*(?=-)/'
	done
}

shell-test() {
  app_string=$(rev <<< $(rev <<< $(ps aux | grep $(lsappinfo info -only pid `lsappinfo front` | awk -F '='  '{print $2}')) | awk -F '/' '{print $1}'))
  app=( $app_string )

  if [ $app = 'Terminal' ];
    then
      ZSH_THEME=powerlevel9k/powerlevel9k;
    else
      ZSH_THEME=gitster;
    fi
}

# Strip extra macOS files from Archives
strip() {
  zip -d $1 __MACOSX/\*;
}

zipstrip () {
	if [ ! $1 ];
		then # If there no are arguments set destination and source
  		destination=~/Desktop/Archive.zip;
			source=.;
  elif [ ! $2 ];
		then # If there is only one argument set the first argument as destination
			destination=$1;
			source=.;
	else
		destination=$1;
		source=$2;
	fi

	echo "Zipping ${source} to ${destination}";

	tmp=$( date "+%s" ).zip;
	zip -qr /tmp/${tmp} $source;
	strip /tmp/${tmp};
	mv /tmp/${tmp} $destination;
}

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

export JAVA_HOME=$(/usr/libexec/java_home)
eval "$(fasd --init auto)"
tabs -2

greeting
