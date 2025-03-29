cd ~
set -e
PROJECT_DIR=$(dirname $0)

sudo dnf install -y hydrapaper openrgb ddcutil

gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type nothing

sudo cp $PROJECT_DIR/scripts/adjust_rgb_brightness_by_time.sh       /usr/local/bin/adjust_rgb_brightness_by_time.sh
sudo cp $PROJECT_DIR/scripts/adjust_display_brightness_by_time.sh   /usr/local/bin/adjust_display_brightness_by_time.sh
sudo cp $PROJECT_DIR/scripts/adjust_display_brightness_on_login.sh  /usr/local/bin/adjust_display_brightness_on_login.sh

sudo chmod +x /usr/local/bin/adjust_rgb_brightness_by_time.sh
sudo chmod +x /usr/local/bin/adjust_display_brightness_by_time.sh
sudo chmod +x /usr/local/bin/adjust_display_brightness_on_login.sh

mkdir -p ~/.config/systemd/user
cp $PROJECT_DIR/systemd-units/adjust_rgb_brightness_by_time.service             ~/.config/systemd/user/adjust_rgb_brightness_by_time.service
cp $PROJECT_DIR/systemd-units/adjust_rgb_brightness_by_time.timer               ~/.config/systemd/user/adjust_rgb_brightness_by_time.timer
cp $PROJECT_DIR/systemd-units/user/adjust_display_brightness_by_time.service    ~/.config/systemd/user/adjust_display_brightness_by_time.service
cp $PROJECT_DIR/systemd-units/adjust_display_brightness_by_time.timer           ~/.config/systemd/user/adjust_display_brightness_by_time.timer
cp $PROJECT_DIR/systemd-units/adjust_display_brightness_on_login.service        ~/.config/systemd/useradjust_display_brightness_on_login.service

systemctl --user enable --now adjust_rgb_brightness_by_time.service
systemctl --user enable --now adjust_rgb_brightness_by_time.timer
systemctl --user enable --now adjust_display_brightness_by_time.service
systemctl --user enable --now adjust_display_brightness_by_time.timer
systemctl --user enable --now adjust_display_brightness_on_login.service

echo All done.
echo Don't forget to manually set refresh rate for monitors in Settings.
