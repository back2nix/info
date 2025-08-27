# прибавить звук
pactl list | grep 'Sink'
pactl -- set-sink-volume alsa_output.pci-0000_09_00.1.hdmi-stereo 50%

pw-top
pw-dump | grep -A5 -B5 recording_sink


pavucontrol

# Проверить статус Pipewire
systemctl --user status pipewire pipewire-pulse wireplumber

# Посмотреть устройства
wpctl status

# Или через PulseAudio API
pactl list sinks short
