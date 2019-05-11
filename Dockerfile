FROM archlinux/base:latest
LABEL maintainer="paul@jettero.pl"
USER root
WORKDIR /root
COPY poo-include.sh /etc/profile.d/
RUN chmod 0755 /etc/profile.d/poo-include.sh
RUN . /etc/profile.d/poo-include.sh; \
    pinstall net-tools iproute2 vim
RUN ln -svf vim /bin/vi
COPY bash-profile /root/.bash_profile
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash", "-o", "vi"]
