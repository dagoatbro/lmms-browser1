FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV DISPLAY=:0

# Install dependencies
RUN apt-get update && apt-get install -y \
    lmms \
    xfce4 \
    x11vnc \
    xvfb \
    novnc \
    websockify \
    supervisor \
    wget \
    net-tools \
    && apt-get clean

# noVNC web client setup
RUN mkdir -p /opt/novnc && \
    ln -s /usr/share/novnc /opt/novnc && \
    ln -s /usr/share/novnc/utils/websockify /opt/novnc/utils/websockify

# Copy Supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 6080
CMD ["/usr/bin/supervisord", "-n"]
