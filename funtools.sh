#!/bin/bash

while [ 1 ]; do
        CHOICE=$(whiptail --title "MENU BOX" --menu "Selecciona un color" 15 60 4 \
                "1" "Zsh+OhMyZsh" \
                "2" "autosuggestions+wd+powerlevel10k" \
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
                        echo "Please restart ZSH: source ~/.zshrc"
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
                echo "Please restart ZSH: source ~/.zshrc"
                ;;

        "0")
                exit
                ;;
        esac

done
exit
