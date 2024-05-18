# установка
- https://www.youtube.com/watch?v=oPymb2-IXbg
- https://nixos.org/manual/nixos/stable/index.html#sec-installation

# install package

```bash
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
# найти пакет
nix-env -qa 'neovim*'
# установить пакет
nix-env -i neovim
# удалить
nix-env -e neovim
# обновить
nix-env -u neovim
nix-env -i --dry-run neovim
```

# youtube
- Грязный способо с pip
- https://www.youtube.com/watch?v=USDbjmxEZ_I&ab_channel=Enthought
- чувак показывает как он работает на пакетами nixos `nixpkgs-review wip`
- https://www.youtube.com/watch?v=D_IZ2EfW_8U&ab_channel=JonRinger
- собирает OpenRGB nix-template
- https://www.youtube.com/watch?v=bkDYmvKINm8&ab_channel=JonRinger
- python310Pacage build python packaging `src = "./.";`
- https://www.youtube.com/watch?v=jXd-hkP4xnU&t=253s&ab_channel=JonRinger
- чувак компилит пакеты
- https://www.youtube.com/watch?v=uATCXO6NSoU&ab_channel=ChrisMcDonough
- mkShell and build общие зависимости
- https://www.youtube.com/watch?v=_8DS6IqqrBA&ab_channel=Tweag
- Pinning specific NVidia driver on NixOS
- https://www.youtube.com/watch?v=j9Z55qkTeS4&ab_channel=junxan
- nixos-build switch, test, boot
- https://www.youtube.com/watch?v=VqUKpNXnRxs&ab_channel=SwitchedtoLinux
- Packaging copier for Nixpkgs 
- https://www.youtube.com/watch?v=6P5kuRADlb8&ab_channel=JonRinger
- hub https://www.nixhub.io/
- https://www.youtube.com/watch?v=yQwW8dkuHqw&ab_channel=Vimjoyer
- devbox
- https://www.jetpack.io/devbox/docs/quickstart/
- nix build, nix develop unpackPhase
- https://www.youtube.com/watch?v=xXlCcdPz6Vc&ab_channel=OpenTechLab
- https://zimbatm.com/
- https://nixos.wiki/wiki/Nixpkgs/Create_and_debug_packages
- virt-manager libvirt
- https://www.youtube.com/watch?v=r8qM6Vw571Y&ab_channel=JohannesSchickling
- https://github.com/ghuntley/ghuntley/blob/trunk/services/dev-ghuntley/templates/nix/Dockerfile
- как создать конфиг и развернуть его
- https://www.youtube.com/watch?v=6WLaNIlDW0M&t=1s&ab_channel=LibrePhoenix
- Batterylife
- https://www.youtube.com/watch?v=pmuubmFcKtg&ab_channel=TechSupportOnHold
- https://github.com/TechsupportOnHold/Batterylife/blob/main/laptop.nix
- Dualboot Refind
- https://www.youtube.com/watch?v=xPfqTWL5jIk&list=UULFgwgHqEsJLFzRO5pRxXs4Bw&ab_channel=TechSupportOnHold
- virt-manager windows 11
- https://www.youtube.com/watch?v=rCVW8BGnYIc&list=UULFgwgHqEsJLFzRO5pRxXs4Bw&index=11&ab_channel=TechSupportOnHold
- nix-init
- https://github.com/nix-community/nix-init

# unpackPhase

- https://www.youtube.com/watch?v=xXlCcdPz6Vc&ab_channel=OpenTechLab
- https://nixos.wiki/wiki/Packaging/Tutorial
- https://nixos.wiki/wiki/Nixpkgs/Create_and_debug_packages

```
git clone https://github.com/jhol/otl-nix-cxx-example
cd otl-nix-cxx-example
nix develop

dontUnpack = true;
dontPath = true;

genericBuild

# $sourceRoot is created in unpack phase, see https://nixos.org/manual/nixpkgs/stable/#ssec-unpack-phase for details.

nix-shell '<nixpkgs>' -A opencv

unpackPhase
cd $sourceRoot 
patchPhase
cmakeConfigurePhase
configurePhase
buildPhase

eval "$configurePhase"
```

# command

```
# собрать deb пакет со всеми зависимостями
nix bundle --bundler bundlers#toDEB nixpkgs#hello
```

# gist

gh gist create /etc/nixos/* или 
cat /etc/nixos/configuration.nix | curl -F"file=@-" https://0x0.st


# venv

```
    buildInputs = with pkgs.python310Packages; [
      venvShellHook
    ];
    venvDir = "venv310";
    postShellHook = ''
      pip install -e .
    '';

```

# overide shell stdenv gcc11

```nix
pkgs.mkShell.override { stdenv = pkgs.gcc11Stdenv; } {
    name = "my-override-shell";
    buildInputs = with pkgs.python310Packages; [
    ];
}
```
# cheat

```bash
# ldd
patchelf --print-needed result/bin/hello

- https://nixos.wiki/wiki/Cheatsheetc
# build static
nix-build -E 'with (import ./. {}); (curl.override { stdenv = makeStaticLibraries stdenv;}).out'
# or
nix-build '<nixpkgs>' -A pkgsStatic.qt5
# with debug
nix-build -E 'with import <nixpkgs> {}; enableDebugging st'

# cross build
nix-build '<nixpkgs>' --arg crossSystem '(import <nixpkgs> {}).lib.systems.examples.aarch64-multiplatform' -A tinc
```

# patchelf use

```bash
#! /usr/bin/env nix-shell
#! nix-shell -i bash -p patchelf

for binary in ${@}; do
	patchelf \
		--set-interpreter "$(cat ${NIX_CC}/nix-support/dynamic-linker)" \
		"${binary}"
done
```

- bash file
```bash
#!/usr/bin/env bash
```

- get path to libraries
- echo $(nix-instantiate --eval -E '(import <nixpkgs> {}).sqlite.out+""')

```lua
local command = [[$(nix-instantiate --eval -E '(import <nixpkgs> {}).sqlite.out+"/lib/libsqlite3.so"')]]
-- Выполнение команды и считывание вывода
local handle = io.popen(command)
local result = handle:read "*a"
handle:close()
```

# overlay

- https://github.com/igsha/nix-overlays
- https://github.com/mozilla/nixpkgs-mozilla
- https://github.com/back2nix/nix-shell/tree/main/overlay

# update

```bash
sudo nix-channel --update

sudo nixos-rebuild switch
home-manager switch
nix flake update
```

### upgrade version

- https://nixos.org/manual/nixos/stable/index.html#sec-upgrading

```bash
sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos
nixos-rebuild switch --upgrade
```

### clean garbage

```bash
nix-store --gc
```

### delete generations

```bash
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations 10 11 12 13 14 15 16 17 18 19 20 21
sudo nix-collect-garbage --delete-old
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old
```

### dotfiles
- https://github.com/schickling/dotfiles
- https://github.com/shaunsingh/nix-darwin-dotfiles/tree/main
- https://github.com/librephoenix/nixos-config

### mac
- https://www.youtube.com/watch?v=1dzgVkgQ5mE&ab_channel=JohannesSchickling
- https://github.com/shaunsingh/nix-darwin-dotfiles/tree/main
- https://www.youtube.com/watch?v=KJgN0lnA5mk&ab_channel=junxan
- https://github.com/gwarf/dotfiles#macos-aka-darwin-using-flakes-and-home-manager
- https://github.com/ereslibre/dotfiles
- https://www.youtube.com/watch?v=r0Y7s1sRSUY&ab_channel=MyNixOS
- https://mynixos.com/mynixos/demo-macos
- https://github.com/LnL7/nix-darwin

- Заработало вот это но не полностью и крякнулось совсем
- https://www.youtube.com/watch?v=r0Y7s1sRSUY&ab_channel=MyNixOS
- https://mynixos.com/back-2-nix/m1pro/meta

### overlays
- https://www.monotux.tech/posts/2023/05/nixos-overlay/

### nvidia cuda pr
- https://github.com/NixOS/nixpkgs/pull/167016/files


### nixos xz trojan 5.6.0. 5.6.1

- https://github.com/NixOS/nixpkgs/issues/300055

```sh
 #initially from: https://github.com/NixOS/nixpkgs/issues/300055#issuecomment-2034546410
    system.replaceRuntimeDependencies = [({
        original = pkgs.xz;
        replacement = pkgs.xz.overrideAttrs (finalAttrs: prevAttrs: {
        #(rec {
            version = "5.4.6";
            src = pkgs.fetchurl {
            url = with finalAttrs;
            # The original URL has been taken down.
            # "https://github.com/tukaani-project/xz/releases/download/v${version}/xz-${version}.tar.bz2";
            "mirror://sourceforge/lzmautils/xz-5.4.6.tar.bz2";
            sha256 = "sha256-kThRsnTo4dMXgeyUnxwj6NvPDs9uc6JDbcIXad0+b0k=";
            };

#Can't use this due to no Makefile or something like that:                                                
#            src = pkgs.fetchgit {
#            url = "https://git.tukaani.org/xz.git";
#            rev = "v${finalAttrs.version}";
#            hash = "sha256-uMUwR1I42R4hip5bJ1KOBKLZd9bb683z7xKeyB3M1Qg=";
#            };
            });
        })];
```

- create package
- https://www.youtube.com/watch?v=CqFcl4BmbN4
