{
  pkgs ? import <nixpkgs> {},
}:
pkgs.mkShell {
  # Пакеты, необходимые для прошивки по инструкции.
  packages = with pkgs; [
    # Аналог Odin для Linux, используется для прошивки recovery.img.
    heimdall

    # Утилиты Android Debug Bridge (ADB), нужны для команды adb sideload.
    android-tools
  ];

  shellHook = ''
    echo "-----------------------------------------------------------"
    echo "Nix Shell для прошивки Samsung S10 активирован."
    echo ""
    echo "Доступные команды:"
    echo "  - heimdall (для прошивки recovery)"
    echo "  - adb      (для sideload прошивки и Magisk)"
    echo ""
    echo "Держите этот терминал открытым на протяжении всего процесса."
    echo "-----------------------------------------------------------"
  '';
}
