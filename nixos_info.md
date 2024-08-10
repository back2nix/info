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
- search devbox
- https://www.nixhub.io/packages/go
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

# override shell stdenv gcc11

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
#! nix-shell -i bash
#! nix-shell -p patchelf

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

sudo NIXPKGS_ALLOW_UNFREE=1 nixos-rebuild switch
sudo nixos-rebuild switch
home-manager switch
nix flake update
```

```bash
sudo nix-channel --list
#sudo nix-channel --add https://nixos.org/channels/nixos-23.11 nixos
sudo nix-channel --add https://nixos.org/channels/nixos-24.05 nixos
nixos-rebuild switch --upgrade
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
- nix store prefetch-file --hash-type sha256 --json "$CUDA_RUNFILE_URL" > cuda_runfile_prefetch.json
- https://github.com/admercs/nixpkgs/commit/6fbd12c2a062abe04528230998f36730287b6fbd
- https://github.com/SomeoneSerge/nixpkgs-cuda-ci/tree/develop
```nix
nix run github:SomeoneSerge/nixpkgs-unfree/nixpkgs-unstable#blender
```

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

- if else options
- https://www.youtube.com/watch?v=Qull6TMQm4Q


```mac
sudo ip link set dev wlp0s20f3 down
sudo ip link set dev wlp0s20f3 address 00:00:11:22:33:44
sudo ip link set dev wlp0s20f3 up
```

- secrests sops
https://www.youtube.com/watch?v=gdxlc5a6ne0


- https://blog.yaymukund.com/posts/nixos-overriding-packages/
- packages in master
```nix
# in packages/neovim-mukund.nix
let neovim-master = (import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/master.tar.gz") {}).neovim
in
  environment.systemPackage = [
    neovim-master
  ]
```

- sound settings
helvum, qpwgraph, pavucontrol, pwvucontrol

- get path

```bash
export NIXPKGS_ALLOW_UNFREE=1
nix repl --expr 'import <nixpkgs>{}'
nix-repl> cudatoolkit.drvPath
nix-repl> cudatoolkit.outPath

environment.sessionVariables.LD_LIBRARY_PATH = [
"/run/opengl-driver/lib/"
];
```

- ollama

```bash
export LD_LIBRARY_PATH=/run/opengl-driver/lib/:$LD_LIBRARY_PATH
ollama server
```

```bash
python -c 'import cupy; cupy.show_config()'
```

- cuda custom
https://github.com/spaceandtimelabs/blitzar/blob/c7e9b40fbe1ec1d612b72d913ade9119ff0fd472/nix/cuda.nix#L10

- error
- Failed to start transient service unit: Unit nixos-rebuild-switch-to-configuration.service was already loaded or has a fragment file.
- fix
- nixos-generate-config

- flake tutorial
- https://nixos-and-flakes.thiscute.world/introduction/
- https://community.flake.parts/services-flake/start
- https://flake.parts/options/process-compose-flake
- отправная точка для настройка mac
- https://github.com/ryan4yin/nix-darwin-kickstarter
- find function nix
- https://noogle.dev/

- flake docker templates
- https://github.com/the-nix-way/nix-docker-examples
- https://www.youtube.com/watch?v=l17oRkhgqHE
- docker nix example
- https://github.com/docker/babashka-pod-docker
- https://ryantm.github.io/nixpkgs/builders/images/dockertools/
- nix shell image
```nix
with import <nixpkgs> {};
dockerTools.buildNixShellImage {
  drv = hello;
}
```

- flake template for dev
- https://github.com/nix-community/templates
- https://github.com/MordragT/nix-templates/
- https://github.com/the-nix-way/dev-templates

- awensom flake
- https://github.com/nix-community/awesome-nix?tab=readme-ov-file#development

- ollama + webui
- https://github.com/juspay/services-flake/blob/86acbd5f04881ba3ea27bdd36c3f9803adc11958/example/llm/flake.nix
- https://github.com/rosera/nix-shell-pack/tree/e9a25e3c4a339d34d108c2fcdc0292227541954f/applications/ollama-rag

- lorrin init

```bash
lorri init
lorri shell
```

- разные способы исполняемого файл fhs ld NIX_LD_LIBRARY_PATH NIX_LD
https://unix.stackexchange.com/questions/522822/different-methods-to-run-a-non-nixos-executable-on-nixos

### develop with my shell
nix develop -c $SHELL
nix develop -c zsh

### testing

- https://nixcademy.com/2023/10/24/nixos-integration-tests/

```bash
git clone https://github.com/nixos/nixpkgs --depth=1
cd nixpkgs
nix-build -A nixosTests.bittorrent
```

### useful linux util
- json viewer
https://fx.wtf/key-bindings
nix-shell -p fx

https://www.youtube.com/watch?v=4IqsqWLqR9Y

- serarch and replace
nix-shell -p serpl

- удалить зависимости
nix-shell -p kondo

- сравнивалка difft
nix-shell -p difftastic

- пакетное рекурсивное переименование
nix-shell -p rnr

- исправляет не правильно введенную команду
nix-shell -p thefuck

- lazydocker
nix-shell -p lazydocker

- красивый конфиг flake nix
https://git.voronind.com/voronind/nixos/src/branch/main/flake.nix

- docker-compose to nix
https://github.com/aksiksi/compose2nix

- play list nix conf
https://www.youtube.com/watch?v=gXHG3-CZ7CU&list=PLh1QjGnfC2eTLiadQBo5o_l5aOcYdC6aV&index=1

- замер времени
nix-shell -p hyperfine
hyperfine --runs 1 'nix-shell -p hello'

- Utilities for analyzing application performance
nix-shell -p oxtools

- transparent vpn ssh
- https://github.com/sshuttle/sshuttle/tree/master?tab=readme-ov-file
- https://sshuttle.readthedocs.io/en/stable/usage.html
nix-shell -p sshuttle
```bash
sshuttle --dns -r shadowsocks2 0/0
```

- https://devenv.sh/

- собрать пакет в один переносимый пакет
- https://github.com/matthewbauer/nix-bundle
- https://github.com/NixOS/bundlers

```bash
nix run github:nlewo/nix2container#examples.bash.copyToPodman
podman run -it bash
```

- docker registry nix
- https://nixery.dev/

- Data Science
- https://nixos.wiki/wiki/Workgroup:DataScience
- jupyter
- https://github.com/tweag/jupyenv
- https://github.com/nix-community/nix-data-science

- https://www.youtube.com/watch?v=Atn565V7tt8&list=UUVGuvJBjMyli7v1ggX6Klqg&index=3
- nix determinate
- https://install.determinate.systems/

- nix from chat

Александр Бантьев, [04.03.2019 10:38]
Добро пожаловать в русскоязычное сообщество, посвященное Nix и NixOS!
Scroll down for english...
Мы готовы вам помочь с вашими проблемами, вопросами или пожеланиями по Nix/NixOS, но просим вас экономить и наше, и ваше время, и выполнять несложные правила:
0) Личные оскорбления и принижения достоинства других людей запрещены.
1) Этот чат предназначен для обсуждения Nix, NixOS, nixpkgs и смежных тем. Пожалуйста, постарайтесь не отклоняться от них. Для обсуждения прочих вопросов есть @ru_nixos_flood
2) Если вы задаёте вопрос или хотите решить проблему с NixOS, то прилагайте ваш конфиг! Вы можете залить его на какой-нибудь pastebin, например с помощью gh gist create /etc/nixos/* или cat /etc/nixos/configuration.nix | curl -F"file=@-" https://0x0.st.
3) Если вы просите опакетить какое-либо ПО в Nix, то прилагайте ссылку на upstream и (при наличии) уже написанные nix expressions!
4) Следуйте советам, изложенным в https://sitengine.ru//smart-question-ru.html
5) Рекрутинг/предложения работы разрешены, при условии релевантности к Nix/NixOS и вашей готовности отвечать на вопросы в чате.

Ищите полезные ссылки и примеры конфигов чуть ниже!

Александр Бантьев, [04.03.2019 11:05]
Welcome to our russian-speaking Nix and NixOS community!
We're ready to help you with your NixOS problems and questions, but you are kindly asked to follow these simple rules in order to save both your time and our time:
0) Insulting others is prohibited.
1) This is a chat about Nix, NixOS and related topics. Please, stay on those topics. For other discussions, use @ru_nixos_flood
2) If your question relates to NixOS, please post your NixOS configuration! You can upload it to some pastebin, for example gh gist create /etc/nixos/* or cat /etc/nixos/configuration.nix | curl -F"file=@-" https://0x0.st .
3) If you ask us to package some piece of software in Nix, add a link to software's upstream!
4) Please follow the advice outlined in http://www.catb.org/~esr/faqs/smart-questions.html
5) Recruitment/vacancy announcements are allowed, but they must be relevant to Nix/NixOS and you must be ready to answer questions about them.

Look for useful links below!

Flood/off-topic chat: https://t.me/ru_nixos_flood
Matrix space: #ru_nixos:balsoft.ru
 (https://matrix.to/#/%23ru_nixos:balsoft.ru)Bridged Matrix room: #ru:nixos.org (https://matrix.org/#/#ru:nixos.org)

 (https://matrix.to/#/%23nixos:balsoft.ru)Для новичков / For beginners
Классическое вступление в мир Nix: nixos.org/nixos/nix-pills
Незаконченный перевод на русский: nix-pills-ru.github.io/00-preface.html
Официальная документация экосистемы: nix.dev

Мануалы / Manuals
В консоле: man configuration.nix home-configuration.nix
Официальный мануал по пакетному менеджеру: nixos.org/nix/manual
Официальный мануал по репозиторию и написанию своих пакетов: nixos.org/nixpkgs/manual
Официальный мануал по дистрибутиву: nixos.org/nixos/manual
Мануал по home-manager: nix-community.github.io/home-manager

Поисковики / Indexers
Поиск по пакетам nixpkgs и опциям NixOS: search.nixos.org
 (http://search.nixos.org/)Неофициальный поиск по разным Nix-штукам: mynixos.com
Неофициальный поиск по home-manager: mipmip.github.io/home-manager-option-search
Неофициальный поиск старых версий пакетов в nixpkgs: lazamar.co.uk/nix-versions
Неофициальный поиск по функциям, написанным на Nix: noogle.dev

Справочники / References
Официальная вики: wiki.nixos.org
Неофициальная вики: nixos.wiki
Неофициальный справочник по стандартной библиотеке nixpkgs и встроенным в Nix функциям:  teu5us.github.io/nix-lib.html

Прочее полезное / Other useful stuffs
Статус PR в nixpkgs после мержа: nixpk.gs/pr-tracker.html
Краткая инструкция по переделыванию конфига на флейки (на русском): t.me/ru_nixos/119078
Статьи о Nix (на русском): ruhaskell.org/tags/Nix.html
stop-using-nix-env.privatevoid.net

Конфиги активных участников / Active user's configs
@alex3rd github.com/wiedzmin/nixos-config
@balsoft github.com/balsoft/nixos-config
@SeTSeR github.com/setser/nixos-config
@savage42 github.com/vyorkin/nixos-config
@saksmt https://github.com/saksmt/nix-config
@termslang https://bitbucket.org/bzz/nixos
@dump_stack https://code.dumpstack.io/infra
@kanashimia https://github.com/kanashimia/nixos-config
@CabiaRangris http://github.com/cab404/nixos-config
@azahicc  https://git.azahi.cc/nixfiles/
@voronind_com https://git.voronind.com/voronind/nixos
@ViZiD https://github.com/ViZiD/dotfiles
@name_snrl https://github.com/name-snrl/nixos-configuration
@maxmur https://github.com/TheMaxMur/NixOS-Configuration
@s0me1newithhand7s https://github.com/s0me1newithhand7s/myNixConf/tree/main
@fucin_shtrampantunc https://github.com/SHTRAMPANTUNC/MyNixOS

Наши соседи / Next-door chats
https://t.me/nixos_en
https://t.me/gnu_guix_ru
https://t.me/haskellru
https://t.me/emacs_ru

Welcome to our russian-speaking Nix and NixOS community!
We're ready to help you with your NixOS problems and questions, but you are kindly asked to follow these simple rules in order to save both your time and our time:
0) Insulting others is prohibited.
1) This is a chat about Nix, NixOS and related topics. Please, stay on those topics. For other discussions, use @ru_nixos_flood
2) If your question relates to NixOS, please post your NixOS configuration! You can upload it to some pastebin, for example gh gist create /etc/nixos/* or cat /etc/nixos/configuration.nix | curl -F"file=@-" https://0x0.st .
3) If you ask us to package some piece of software in Nix, add a link to software's upstream!
4) Please follow the advice outlined in http://www.catb.org/~esr/faqs/smart-questions.html
5) Recruitment/vacancy announcements are allowed, but they must be relevant to Nix/NixOS and you must be ready to answer questions about them.

Look for useful links below!

Александр Бантьев, [04.03.2019 11:08]
Flood/off-topic chat: https://t.me/ru_nixos_flood
Matrix space: #ru_nixos:balsoft.ru
 (https://matrix.to/#/%23ru_nixos:balsoft.ru)Bridged Matrix room: #ru:nixos.org (https://matrix.org/#/#ru:nixos.org)

 (https://matrix.to/#/%23nixos:balsoft.ru)Для новичков / For beginners
Классическое вступление в мир Nix: nixos.org/nixos/nix-pills
Незаконченный перевод на русский: nix-pills-ru.github.io/00-preface.html
Официальная документация экосистемы: nix.dev

Мануалы / Manuals
В консоле: man configuration.nix home-configuration.nix
Официальный мануал по пакетному менеджеру: nixos.org/nix/manual
Официальный мануал по репозиторию и написанию своих пакетов: nixos.org/nixpkgs/manual
Официальный мануал по дистрибутиву: nixos.org/nixos/manual
Мануал по home-manager: nix-community.github.io/home-manager

Поисковики / Indexers
Поиск по пакетам nixpkgs и опциям NixOS: search.nixos.org
 (http://search.nixos.org/)Неофициальный поиск по разным Nix-штукам: mynixos.com
Неофициальный поиск по home-manager: mipmip.github.io/home-manager-option-search
Неофициальный поиск старых версий пакетов в nixpkgs: lazamar.co.uk/nix-versions
Неофициальный поиск по функциям, написанным на Nix: https://noogle.dev

Справочники / References
Официальная вики: wiki.nixos.org
Неофициальная вики: nixos.wiki
Неофициальный справочник по стандартной библиотеке nixpkgs и встроенным в Nix функциям:  teu5us.github.io/nix-lib.html

Прочее полезное / Other useful stuffs
Статус PR в nixpkgs после мержа: nixpk.gs/pr-tracker.html
Краткая инструкция по переделыванию конфига на флейки (на русском): t.me/ru_nixos/119078
Статьи о Nix (на русском): ruhaskell.org/tags/Nix.html
stop-using-nix-env.privatevoid.net

Конфиги активных участников / Active user's configs
@alex3rd github.com/wiedzmin/nixos-config
@balsoft github.com/balsoft/nixos-config
@SeTSeR github.com/setser/nixos-config
@savage42 github.com/vyorkin/nixos-config
@saksmt https://github.com/saksmt/nix-config
@termslang https://bitbucket.org/bzz/nixos
@dump_stack https://code.dumpstack.io/infra
@kanashimia https://github.com/kanashimia/nixos-config
@CabiaRangris http://github.com/cab404/nixos-config
@azahicc  https://git.azahi.cc/nixfiles/
@voronind_com https://git.voronind.com/voronind/nixos
@ViZiD https://github.com/ViZiD/dotfiles
@name_snrl https://github.com/name-snrl/nixos-configuration
@maxmur https://github.com/TheMaxMur/NixOS-Configuration
@s0me1newithhand7s https://github.com/s0me1newithhand7s/myNixConf/tree/main
@fucin_shtrampantunc https://github.com/SHTRAMPANTUNC/MyNixOS

Наши соседи / Next-door chats
https://t.me/nixos_en
https://t.me/gnu_guix_ru
https://t.me/haskellru
https://t.me/emacs_ru

- классная презентация включая nixos anywehere
https://www.youtube.com/watch?v=6iviTZfiLGU

показать картинку в терминале
```bash
kitten icat qr_code_nixos_presentation.png
```

- nix shell vs nix develop
https://blog.ysndr.de/posts/guides/2021-12-01-nix-shells/

- WSL2 nixos
https://github.com/LGUG2Z/nixos-wsl-starter

### lorri fix

Похоже, у вас возникла проблема с правами доступа при попытке использовать lorri и direnv. Ошибка указывает на то, что у вас нет разрешения на создание каталога в /nix/var/nix/gcroots/per-user/bg.

Вот несколько шагов, которые могут помочь решить эту проблему:

1. Проверьте права доступа к каталогу:
   Выполните команду:
   ```
   ls -ld /nix/var/nix/gcroots/per-user
   ```
   Убедитесь, что у вашего пользователя есть права на запись в этот каталог.

2. Создайте каталог вручную:
   Попробуйте создать каталог вручную с помощью sudo:
   ```
   sudo mkdir -p /nix/var/nix/gcroots/per-user/$USER
   sudo chown $USER:$USER /nix/var/nix/gcroots/per-user/$USER
   ```

3. Проверьте настройки Nix:
   Убедитесь, что ваш пользователь правильно настроен в конфигурации Nix. Проверьте файл /etc/nix/nix.conf.

4. Перезапустите nix-daemon:
   ```
   sudo systemctl restart nix-daemon
   ```

5. Очистите кэш direnv:
   ```
   direnv prune
   ```

После выполнения этих шагов попробуйте снова запустить `lorri shell`.

Если проблема сохраняется, возможно, потребуется более глубокий анализ вашей конфигурации Nix и системных прав. В таком случае, дайте мне знать, и мы можем рассмотреть дополнительные шаги для решения проблемы.

- re packing nix package
https://www.youtube.com/watch?v=nc1UtAfcbxI

- NixOS Automated Remote Bootstrapping with Secrets - Part 4/4 Scripting the Order of Operations
- https://www.youtube.com/watch?v=X9xPgnBR7ow

- Proxy SwitchyOmega
- ~/.config/google-chrome/Default/Extensions/padekgcemlokbadohgkifijomclgjgif


Five Terminal Applications I CAN'T Live Without
- https://www.youtube.com/watch?v=1QqvL-k11NE
- atac - analog postman
