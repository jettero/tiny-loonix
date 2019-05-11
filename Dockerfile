FROM archlinux/base:latest
LABEL maintainer="paul@jettero.pl"
RUN PM='pacman --cachedir /poo --noconfirm --noprogressbar' \
  ; $PM -Sy --needed archlinux-keyring \
 && $PM -S  --needed pacman \
 && $PM -S  --needed net-tools iproute2 \
 && rm -rf /poo
