cd ~
set -e
PROJECT_DIR=$(dirname $0)


echo "
max_parallel_downloads=10
defaultyes=True
keepcache=True
" | sudo tee -a /etc/dnf/dnf.conf

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
cp -r $PROJECT_DIR/fonts/* ~/.local/share/fonts
cp $PROJECT_DIR/inis/gnome-with-white-font.palette ~/.local/share/org.gnome.Ptyxis/palettes/gnome-with-white-font.palette
fc-cache
gsettings set org.gnome.Ptyxis use-system-font false
gsettings set org.gnome.Ptyxis font-name 'MesloLGS NF 11'
dconf write /org/gnome/Ptyxis/Profiles/$(gsettings get org.gnome.Ptyxis profile-uuids | tr -d "[]',")/palette "'gnome-with-white-font'"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
sed -i 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' ~/.zshrc
sed -i 's|^plugins=(.*)|plugins=(aws kubectl)|' ~/.zshrc
echo "
source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
bindkey \^U backward-kill-line
export KUBE_EDITOR=vim
" >> ~/.zshrc


cp $PROJECT_DIR/inis/.gitconfig ~/.gitconfig
echo -e "\nset expandtab\nset tabstop=2\nset shiftwidth=2" | sudo tee -a /etc/vimrc


cp $PROJECT_DIR/images/rocket-3440-1440.png ~/.local/share/backgrounds/2025-01-01-00-00-00-rocket-3440-1440.png
gsettings set org.gnome.desktop.background picture-uri 'file:///home/try_catch_finally/.local/share/backgrounds/2025-01-01-00-00-00-rocket-3440-1440.png'
gsettings set org.gnome.desktop.background picture-uri-dark 'file:///home/try_catch_finally/.local/share/backgrounds/2025-01-01-00-00-00-rocket-3440-1440.png'
gsettings set org.gnome.desktop.background primary-color '#000000000000'
gsettings set org.gnome.desktop.background secondary-color '#000000000000'


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
gsettings set org.gnome.desktop.wm.keybindings begin-move '[]'
gsettings set org.gnome.desktop.wm.keybindings begin-resize '[]'
gsettings set org.gnome.desktop.wm.keybindings cycle-group "[]"
gsettings set org.gnome.desktop.wm.keybindings cycle-group-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings cycle-panels "[]"
gsettings set org.gnome.desktop.wm.keybindings cycle-panels-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows "[]"
gsettings set org.gnome.desktop.wm.keybindings cycle-windows-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1 "[]"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-last "[]"
gsettings set org.gnome.desktop.wm.keybindings panel-run-dialog "[]"
gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "[]"
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-group "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-group-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Shift>Alt_L']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Alt>Shift_L']"
gsettings set org.gnome.desktop.wm.keybindings switch-panels "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-panels-backward "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Super>Page_Up', '<Super><Alt>Left']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Super>Page_Down', '<Super><Alt>Right']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
gsettings set org.gnome.mutter center-new-windows true
gsettings set org.gnome.mutter workspaces-only-on-primary false
gsettings set org.gnome.mutter.wayland.keybindings restore-shortcuts '[]'
gsettings set org.gnome.settings-daemon.plugins.media-keys control-center "['<Super>i']"
gsettings set org.gnome.settings-daemon.plugins.media-keys help '[]'
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier '[]'
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-in '[]'
gsettings set org.gnome.settings-daemon.plugins.media-keys magnifier-zoom-out '[]'
gsettings set org.gnome.settings-daemon.plugins.media-keys screenreader '[]'
gsettings set org.gnome.settings-daemon.plugins.power power-button-action interactive
gsettings set org.gnome.shell.app-switcher current-workspace-only true
gsettings set org.gnome.shell.weather locations "[$KYIV_LOCATION]"
gsettings set org.gnome.shell.world-clocks locations "[$REYKJAVIK_LOCATION]"
gsettings set org.gnome.system.locale region 'en_GB.UTF-8'
gsettings set org.gnome.Weather locations "[$KYIV_LOCATION]"
timedatectl set-timezone Europe/Kyiv


cp $PROJECT_DIR/audios/service-login.wav /usr/share/sounds/freedesktop/stereo/service-login.wav 
cp $PROJECT_DIR/inis/login-sound.desktop ~/.config/autostart/login-sound.desktop
cp $PROJECT_DIR/inis/org.telegram.desktop.desktop ~/.config/autostart/org.telegram.desktop.desktop

sudo cp $PROJECT_DIR/scripts/toggle_keyboard_input_sources.sh /usr/local/bin/toggle_keyboard_input_sources.sh
sudo chmod +x /usr/local/bin/toggle_keyboard_input_sources.sh

CUSTOM0_BINDING_PATH=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['$CUSTOM0_BINDING_PATH']"
dconf write ${CUSTOM0_BINDING_PATH}name "'Toggle keyboard layouts'"
dconf write ${CUSTOM0_BINDING_PATH}command "'bash /usr/local/bin/toggle_keyboard_input_sources.sh'"
dconf write ${CUSTOM0_BINDING_PATH}binding "'<Control><Alt>u'"

echo All done.
echo Install theme for Telegram: https://t.me/addtheme/DarkShell
