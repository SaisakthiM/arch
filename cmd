sudo cp /etc/pacman.conf /etc/pacman.conf.bak
sudo bash -c 'cat > /etc/pacman.conf' <<EOF
[options]
HoldPkg     = pacman glibc
Architecture = auto
CheckSpace
SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist

[community]
Include = /etc/pacman.d/mirrorlist
EOF

sudo pacman -Sy reflector --noconfirm
sudo reflector --country India --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -Syyu --noconfirm
