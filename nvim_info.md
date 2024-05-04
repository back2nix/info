### neovim nvim cpp ide config
- https://github.com/optimizacija/neovim-config

### clang 8
- https://solarianprogrammer.com/2017/12/13/linux-wsl-install-clang-libcpp-compile-cpp-17-programs/

### добавить в CMake для ycm youcompleteme появится файл .clang_complete
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)

### рефакторинг :args :argsdo
### Найти все файлы в которых слово profile не находится на одной строке с github
args `ack -l '^(?!.*github).(\bprofile\b)' *`
### Посмотреть какие файлы находятся в args
args
### Заменить во всех файлах находящихся в args
### argdo %s/\%(github.*\)\@<!\<profile\>\>/profile0000/g

### Сохранить все изменения в файлах args
argdo update

sudo apt clean
sudo apt update
sudo apt purge cuda
sudo apt purge nvidia-*
sudo apt autoremove

sudo apt-get --purge remove "*cublas*" "cuda*" "nvidia-cuda*"
sudo apt-get --purge remove "*nvidia*"

### работа с git
- https://github.com/airblade/vim-gitgutter
#stage the hunk with 
<Leader>hs or
#undo it with 
<Leader>hu.

### python3 Autocomplete
#https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/
sudo -H pip3 install pynvim jedi
Plug 'zchee/deoplete-jedi'

### Neovim config for frontend development
### https://www.bha.ee/neovim-config-for-frontend-development/

### Прыгать по коду python
#<leader>d: go to definition
#K: check documentation of class or method
#<leader>n: show the usage of a name in current file
#<leader>r: rename a name


### рефакторинг
### https://jdhao.github.io/2020/03/14/nvim_search_replace_multiple_file/

### ищем
:vimgrep /Neovim/gj **/*
### потом открываем
:copen
:cn -- Go to the next location in the list
:cp -- Go to the previous location
:ccl -- Close the quickfix window

### меняем grep на ripgrep
#set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
#set grepformat=%f:%l:%c:%m

### Ищем
grep Neovim
### Меняем
cfdo %s/Neovim/Nvim/ge | update

### :Git vim-fugitive
### g? help
- # stage unstage this fiel
X # Отменить изменения в этом файле
= # Открыть diff файла под курсором
I # добавлять в stage изменения построчно

### http://vimcasts.org/episodes/fugitive-vim-exploring-the-history-of-a-git-repository/
### Загрузить все фиксации в quickfix list
Glog -- %
[q	:cprev	jump to previous quickfix item
]q	:cnext	jump to next quickfix item
[Q	:cfirst	jump to first quickfix item
]Q	:clast	jump to last quickfix item

### http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/

### складывание вкладок http://vimcasts.org/episodes/how-to-fold/

### скопировать строку быстрее http://vimcasts.org/episodes/long-range-line-duplication/
-7t. # (отслюда)t(скопировать сюда в текущую строку)

### как пользоваться Gdiff http://vimcasts.org/episodes/fugitive-vim-working-with-the-git-index/
:Gdiff
:diffget
### :Gwrite
### :Gread
### :diffupdate

### history branch g+ g- undo redo (F5 GundoToggle)

### Таблицы выравнивание
### '<,'>Tabularize /|
### '<,'>Tabularize /=

### Перемещение по изменениям http://vimcasts.org/episodes/using-the-changelist-and-jumplist/
g;
g,
:changes
ctrl-O
ctrl-I
:jumps

### vim documentation jumps
ctrl-]

### вставить vim :0put +
:0put +

## самые качественные
asus strix quiet 3090

## syslog set filetype=messages
set filetype=messages

## golangci-lint-langserver nvim
- https://github.com/nametake/golangci-lint-langserver
:CocConfig

```yaml
{
  "languageserver": {
    "golangci-lint-languageserver": {
      "command": "golangci-lint-langserver",
      "filetypes": ["go"],
      "initializationOptions": {
        "command": ["golangci-lint", "run", "--out-format", "json"]
      }
    }
  }
}
```

### atstronvim
- https://astronvim.github.io/
- https://www.youtube.com/watch?v=LKnuIazeiM4


```lua
set noexpandtab
set tabstop=2
set shiftwidth=2
```


- Переход из состояни команды : в состояние bash
- жеме : и жмем shift-1
- сохранить все файлы сразу :wall
- включить прозрачно :TransparentToggle
- TodolocList
- Trouble
- ctr+w (h,j,k,l) преходы по буферам
- <leader>pp yank history
- <leader>j развернуть структуру или свернуть в линию
- жеме " и выбираем какой буфер yank будет активным после можно вставлять
- заградвные буквы это метки которые дествуют между файлами

```go
// NOTE: test notification
// HACK: test hack commment
// FIX: test fix commment
// BUG: test bug commment
// PERF: test preformance commment
// TODO: test todo comment
// WARN: test warning commment
// WARNING:
```

- Neorg export to-file my-file.md
- DBUI ./base.sqlite

- current file
```vim
:echo expand('%:p')
```

- fix nix paths
```~/.local/share/nvim/lazy/sqlite.lua/lua/sqlite/defs.lua
-- local command = [[$(nix-instantiate --eval -E '(import <nixpkgs> {}).sqlite.out+"/lib/libsqlite3.so"')]]
-- local handle = io.popen(command)
-- local result = handle:read "*a"
-- handle:close()
-- local mypath = result:match "^%s*(.-)%s*$"
```

```lua
local linux_paths = {
"/usr/lib/x86_64-linux-gnu/libsqlite3.so",
"/usr/lib/x86_64-linux-gnu/libsqlite3.so.0",
"/usr/lib64/libsqlite3.so",
"/usr/lib/libsqlite3.so",
"/nix/store/n12a68qch9s85k6ni4m4r4xxr8lwys1i-sqlite-3.41.2/lib/libsqlite3.so",
}
```

- configur for c++
- https://www.youtube.com/watch?v=lsFoZIg-oDs&ab_channel=DreamsofCode

- cr pr code review
https://github.com/pwntester/octo.nvim
https://github.com/AstroNvim/astrocommunity/blob/93b0b67cbd156636df5d4789bd26c52270671f98/lua/astrocommunity/git/diffview-nvim/README.md?plain=1#L2

- мульти замена
https://www.youtube.com/watch?v=YzVmdJ41Xkg

:Telescope live_grep glob_pattern=*.{go}
:fW
ctrl+q # отправить в быстрое исправление
cdo %s/Start/Launch/g
cdo %s/Start/Launch/gc
