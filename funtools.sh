#!/bin/bash

while [ 1 ]; do
        CHOICE=$(whiptail --title "MENU BOX" --menu "Installer" 15 60 4 \
                "1" "Zsh+OhMyZsh" \
                "2" "autosuggestions+wd+powerlevel10k" \
                "3" "Extra tools" \
                "0" "Exit" 3>&2 2>&1 1>&3)

        exitstatus=$?
        case $CHOICE in
        "1")
                which zsh
                if [ $? -ne 0 ]; then
                        echo "Installing ZSH"
                        sudo apt install zsh -y
                        echo "Changing shell to zsh.."
                        chsh -s $(which zsh)
                else
                        echo "ZSH already installed, nothing todo.."
                fi        
                if [[ "$ZSH" == *"oh-my-zsh" ]]; then
                        echo "Oh My ZSH already installed, nothing todo.."
                else
                        echo "Installing Oh My ZSH"
                        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
                        . ~/.zshrc
                        echo "finish."
                fi
                ;;
        "2")
                git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
                git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
                sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions wd)/' ~/.zshrc
                sed -i 's#ZSH_THEME="robbyrussell"#ZSH_THEME="powerlevel10k/powerlevel10k"#' ~/.zshrc
                echo "Installing MesloLGS fonts.."
                sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -P /usr/share/fonts/
                sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -P /usr/share/fonts/
                sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -P /usr/share/fonts/
                sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -P /usr/share/fonts/
                . ~/.zshrc
                  echo "finish."
                ;;
        "3")
        npm i -g bash-language-server
        # Enable emojis in terminal and other apps
        sudo apt install fonts-noto-color-emoji -y
        # Test emojis: echo "\U01f98a"
        cargo install tree-sitter-cli
        # python dev
        # pyenv - python versions
        curl https://pyenv.run | bash
        # Add to .zshrc
        # export PATH="$HOME/.pyenv/bin:$PATH"
        # eval "$(pyenv init --path)"
        # eval "$(pyenv virtualenv-init -)"
        # Manage python project dependencies
        sudo apt install pipenv -y
        sudo apt install snapd -y
        sudo snap install firefox --channel=esr/stable
        sudo apt install bluetooth pi-bluetooth bluez blueman -y
        cargo install exa
        cargo install gitui

          ;;
        "0")
                exit
                ;;
        esac

done
exit
