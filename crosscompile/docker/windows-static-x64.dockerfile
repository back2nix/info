FROM dockcross/windows-static-x64

ENV DEFAULT_DOCKCROSS_IMAGE REPO_DEPRECATED/windows-static-x64
RUN apt update; apt install -y meson ninja-build cmake
