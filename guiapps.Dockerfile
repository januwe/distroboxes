FROM quay.io/toolbx-images/debian-toolbox:12

RUN apt update && apt install -y default-jre terminator \
      libgbm1 libgdk-pixbuf2.0-0 libxss1 libcurl4 \
      && wget https://launcher.mojang.com/download/Minecraft.deb \
      && dpkg -i ./Minecraft.deb && rm -rf ./Minecraft.deb \
      && rm -rf /var/lib/apt/lists/*
