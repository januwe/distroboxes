# Distrobox Containers

Here is a collection of my day to day use of distroboxes. I mainly have two distroboxes, one for clitools (e.g. bat, zoxide) and one for GUI Applications (e.g. Discord, Firefox). I tried to create `Dockerfile`'s that are as lightweight as possible, to speed up deployments.

## Containers

### Installation and usage

Make sure you have `distrobox` and either `docker`, `podman` or `lilipod` installed.

1. **Clone and cd into dir**
  ```sh
  git clone https://github.com/januwe/distroboxes && cd ./distroboxes
  ```

2. **Build docker images**
  ```sh
  docker build -f ./clitools.Dockerfile -t clitools .
  docker build -f ./guiapps.Dockerfile -t guiapps .
  ```

3. **Create distrobox container**
  ```sh
  distrobox-create -i clitools -n clitools
  distrobox-create --nvidia -i guiapps -n guiapps
  ```

4. **Enter distrobox container**
  ```sh
  distrobox enter clitools
  ```

  ```sh
  distrobox enter guiapps
  ```

### cli-tools container (dev)

**Available tools**:
  - bat
  - cht.sh
  - exa
  - htop
  - navi
  - zoxide

---

### gui-apps container

**Available gui apps**:
  - BambuStudio
  - BurpSuite
  - Discord
  - Firefox
  - Minecraft-launcher
  - Terminator

---
