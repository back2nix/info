- touchID tmux
- сломался sudo
- https://www.hein.dev/blog/2020/01/using-touchid-tmux-pam_reattach/
- возможное решение
- https://superuser.com/questions/1342926/sudo-with-auth-sufficient-pam-tid-so-does-not-work-with-tmux

```bash
# brew install fabianishere/personal/pam_reattach
brew install pam_reattach
sudo vim /etc/pam.d/sudo
```

```/etc/pam.d/sudo
auth       optional       /opt/homebrew/lib/pam/pam_reattach.so
auth       sufficient     pam_tid.so
```

```
CTRL+A %  разделить окно по вертикали
CTRL+A "   разделить окно по горизонтали
CTRL+A <UP ARROW>  двигаться по окнам
CTRL+A z   full-screen
CTRL+A c   new window(tab)
CTRL+A <window number>   переключится на вкладку с номером
CTRL+A d   Выход
CTRL+A w list windows
CTRL+A &  kill
CTRL+a ,   name window
CTRL+A .    move window - prompted for a new number
CTRL+A :    move window to the next unused number
CTRL+A o   swap panes
CTRL+A q   show pane numbers
CTRL+A x   kill pane
CTRL+A ⍽ # space - toggle between layouts
CTRL+A :joinp -s :2<CR> move window 2 into a new pane in the current window
CTRL+A :joinp -t :1<CR> move the current pane into a new pane in window 1
CTRL+A t # big clock
CTRL+A ? list shortcuts
CTRL+A :  prompt

CTRL+A s # вызываются какое окно

# open terminal failed: missing or unsuitable terminal: xterm-256color
# можно пофиксить
export TERM=xterm
```

``
