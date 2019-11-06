# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

# zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# yarn
curl -o- -L https://yarnpkg.com/install.sh | bash

# brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# remove brew apps
brew bundle cleanup --force

# install brew apps
brew bundle

for file in "symlinks" "plugins" "macOS" "tid" "builder"; do "./scripts/${file}.sh" &> /dev/null; done
