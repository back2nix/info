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

# command

```
# собрать deb пакет со всеми зависимостями
nix bundle --bundler bundlers#toDEB nixpkgs#hello
```

# gist

gh gist create /etc/nixos/* или 
cat /etc/nixos/configuration.nix | curl -F"file=@-" https://0x0.st
