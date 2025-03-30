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

mkdir -p ~/.local/share/fonts
cp -r $PROJECT_DIR/fonts/* ~/.local/share/fonts
cp $PROJECT_DIR/inis/gnome-with-white-font.palette ~/.local/share/org.gnome.Ptyxis/palettes/gnome-white-font.palette
fc-cache
gsettings set org.gnome.Ptyxis use-system-font false
dconf write /org/gnome/Ptyxis/Profiles/$(gsettings get org.gnome.Ptyxis profile-uuids | tr -d "[]',")/palette "'gnome-white-font'"

xclip -selection clipboard <<< 'export SHELL=/usr/bin/zsh && 
  gsettings set org.gnome.Ptyxis font-name "MesloLGS NF 11" && 
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'

echo 'Part1 almost done. Now:
  - enter your password to change user shell;
  - execute the command from clipboard;
  - run part2.sh to proceed.
'

chsh -s /usr/bin/zsh


