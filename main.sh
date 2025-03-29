cd ~
set -e
ASSETS_DIR="$(dirname $0)/assets"


echo -e "max_parallel_downloads=10\ndefaultyes=True" | sudo tee -a /etc/dnf/dnf.conf

sudo dnf remove -y gnome-abrt \
  gnome-calculator \
  gnome-connections \
  gnome-contacts \
  gnome-logs \
  gnome-text-editor \
  gnome-tour \
  rhythmbox \
  simple-scan \
  evince \
  firefox \
  libreoffice-core \
  libreoffice-calc \
  libreoffice-impress \
  libreoffice-writter \
  snapshot \
  totem

sudo dnf autoremove -y
sudo dnf upgrade -y

sudo dnf install -y vim zsh xclip google-chrome-stable vlc kolourpaint
flatpak install -y flathub org.telegram.desktop com.github.ryonakano.reco


# SET UP TERMINAL
# https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#getting-started
cp -r $ASSETS_DIR/fonts/* ~/.local/share/fonts
cp $ASSETS_DIR/inis/gnome-with-white-font.palette ~/.local/share/org.gnome.Ptyxis/palettes/gnome-with-white-font.palette
fc-cache
gsettings set org.gnome.Ptyxis use-system-font false
gsettings set org.gnome.Ptyxis font-name 'MesloLGS NF 11'
dconf write /org/gnome/Ptyxis/Profiles/$(gsettings get org.gnome.Ptyxis profile-uuids | tr -d "[]',")/palette "'gnome-with-white-font'"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc
sed -i 's|^plugins=(.*)|plugins=(aws kubectl)|' ~/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
echo -e '\nbindkey \^U backward-kill-line\nexport KUBE_EDITOR=vim' >> ~/.zshrc


cp $ASSETS_DIR/inis/.gitconfig ~/.gitconfig
echo -e "\nset expandtab\nset tabstop=2\nset shiftwidth=2" | sudo tee -a /etc/vimrc


REYKJAVIK_LOCATION="<(uint32 2, <('Reykjavík', 'BIRK', true, [(1.1193378211279323, -0.38222710618675809)], [(1.1196287151543625, -0.38309977081275531)])>)>"
KYIV_LOCATION="<(uint32 2, <('Kyiv', 'UKKK', true, [(0.87967503764377286, 0.53148185187090402)], [(0.88022771360470919, 0.53261631588470038)])>)>"
gsettings set org.gnome.clocks world-clocks "[{'location': $REYKJAVIK_LOCATION}]"
gsettings set org.gnome.desktop.interface clock-format 24h
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface color-scheme prefer-dark
gsettings set org.gnome.desktop.interface enable-hot-corners false
gsettings set org.gnome.desktop.privacy remember-recent-files false
gsettings set org.gnome.desktop.screensaver lock-enabled true
gsettings set org.gnome.desktop.screensaver lock-delay 0
gsettings set org.gnome.desktop.search-providers disable-external true
gsettings set org.gnome.desktop.session idle-delay 900
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Shift>Alt_L']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Alt>Shift_L']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Page_Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Page_Down']"
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter workspaces-only-on-primary false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.shell.weather locations "[$KYIV_LOCATION]"
gsettings set org.gnome.shell.world-clocks locations "[$REYKJAVIK_LOCATION]"
gsettings set org.gnome.system.locale region 'en_GB.UTF-8'
gsettings set org.gnome.Weather locations "[$KYIV_LOCATION]"
timedatectl set-timezone Europe/Kyiv


cp $ASSETS_DIR/audios/service-login.wav /usr/share/sounds/freedesktop/stereo/service-login.wav 
cp $ASSETS_DIR/inis/login-sound.desktop ~/.config/autostart/login-sound.desktop
cp $ASSETS_DIR/inis/org.telegram.desktop.desktop ~/.config/autostart/org.telegram.desktop.desktop

sudo cp $ASSETS_DIR/scripts/toggle_ukrainian_input_source.sh /usr/local/bin/toggle_ukrainian_input_source.sh
sudo chmod +x /usr/local/bin/toggle_ukrainian_input_source.sh
# set shortcut


echo Install theme for Telegram: https://t.me/addtheme/DarkShell
