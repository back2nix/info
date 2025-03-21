git diff --cached # показать дифф того что в индексе
git diff HEAD myfile.cpp # сравнить файл между коммитами
git diff develop --name-only # сравнить текущую ветку с веткой develop и показать только имена файлов
git diff -w # игнорировать пробелы
git diff --staged

git reflog

git stash # спрятать ваши изменения в карман
git stash --kepp-index # поместить в stash только то что не находится в индексе
git stash -u # -u = --include-untracked поместить в stash то что не трекается
git stash --all # спрятать в stash все, и идексированые и не отслеживаемые и тд..  (git clean - удаляет все изменения и файлы которые не отслеживаются, и восстановить нельзя в отличие от stash)
git stash list # посмотреть то что спрятали
git stash apply stash@{0}  # применить нулевой stash, но при этом stash не удаляется из кармана
git stash pop # применить последний stash и stash удалится из кармана
git stash branch b1 # создать новую ветку b1 из вашего stash. Ветка создастся с того комита в котором вы сдалали stash. Stash успешно применился без конфликтов то он удалится из кармана.

git clean -d -n # покажет но не удалит все что изменилось в вашем репозитории и даже не отслеживаем файлы
git clean -d -n -x # покажет прекомпилированне *.o
git clean -x -f # удалить безвозвратно все изменения и не отслеживаемые файлы
git clean -d --force # Удалить неиндексированные файлы и папки.

git grep -n "#include"   # покажет в каких файлах и на какой строке есть эта строка
git grep -c "#include"  # покажет количество совпадений в каждом файле
git grep -pn "std" # в каких функциях есть это совпадение и на какой строке
git grep -n -e "^void v(" --and -e ";" # искать чтобы совпадало и первое и второе выражение в одной строке

git log --oneline --graph # для своей ветки
git log --graph --oneline --all # вывести лог ввиде графа, для всех веток
git log --oneline --decorate --all --graph # вывести лог ввиде графа и показать stash и мена веток
git log --pretty=oneline # вывести log компактно по одной строчке на коммит
git log --author=REPO_DEPRECATED # посмотреть комиты автора
git log -S vector --oneline # найти в истории где создавалась или удалялось это слово "vector"
git log -L :main:main.cpp  # увидеть все изменения функции main в файле main.cpp
git log -p myFile.cpp # посмотреть историю одного файла
git log --no-merges master # показать не смерженное с master
git log -L 1,1:some-file.txt # показать изменения для некоторых строк в файле
git log --pretty="%h - %s" --author=REPO_DEPRECATED # посмотреть которкие хеши
#если хотим найти потерянный файл в истории
git log --all --full-history -- **/thefile.* # если не знаем путь к искомому файлу
git log --all --full-history -- <path-to-file> # если знаем полный путь к искомому файлу
git log --name-status develop # помотреть какие файлы были изменены в коммите

git commit --amend -m "my new message" # изменить сообщение последнего коммита если вы еще на сделали push
git commit --amend

git add file1 file2 file3
git commit --amend --no-edit
git log --follow -- linaro # Показать комиты для одного файла

git rebase -i HEAD~3 # изменить в интерактивном режиме последние три коммита
git rebase --continue
git rebase -Xtheirs b1

git filter-branch --tree-filter 'rm -f passwords.txt' HEAD # удалить файл passwords.txt из всех коммитов

git reset --soft HEAD~ # удалит предыдущий комит и добавить его в индекс, после чего его можно отредактировать и закомитить снова
git reset --hard HEAD  # жесткий брос всех изменений, после этого можно потерять свои наработки навсегда
git reset HEAD@{index}

git merge --abort # отменить попытку слияния
git merge-file -p hello.ours.rb hello.common.rb hello.theirs.rb > hello.rb
git merge -Xours b1 # при конфликте выбирать наши изменения
git merge -Xtheirs b1 # при конфликте выбирать их изменения
git merge myBranch --no-commit --no-ff #делаем мерж без комита, изменения будут в индексе


#сделать сокращение для команды
git config --global alias.tree "log --oneline --decorate --all --graph"

git cherry-pick 7958482 # 7958482 <- хеш коммита который нужно преместить в свою ветку

git checkout develop -- file.cpp # получить версию файла из develop
git checkout -p file.cpp # построчная отмена
git checkout [тот хэш] --path/to/file

git show develop:some-file.js # извлекает файл из другой ветки

git revert -n 0fxf077 # создать новый комит который будет отменять другой и добавит его в индекс без коммита
git revert  [тот хэш]

git revert -m 1 23232323

git add -p # interactive интерактив добавить только некоторые изменения из файла

git submodule add git@github.com:REPO_DEPRECATED/lfs_test0.git # добавить submodule
git submodule update --init --recursive # без коментариев

git clone --depth 1 # чтобы не скачивать весь репо

# git store large file image png jpg binary bin; хранение больших файлов в гит
# git-lfs
curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash
git lfs install # в каждом новом проекте где нужны большие файлы
git lfs track "*.psd" # помечаем какие файлы нужно конролировать
git add .gitattributes

# Создать tag
git tag -a v1.1.002 -m "version 1.1.002"
# Пушнуть tag
git push origin v1.1.002
git push --force-with-lease # Запушить чтобы не перетереть чужие изменения
# delete tag
git tag -d 0.0.18
# пушнуть
git push origin --delete 0.0.18

# delete big file from all history
https://rtyley.github.io/bfg-repo-cleaner/
java -jar bfg.jar --strip-blobs-bigger-than 100M .
git reflog expire --expire=now --all && git gc --prune=now --aggressive

git fetch origin
git checkout master
git reset --hard origin/master
# Удалить неиндексированные файлы и папки.
git clean -d --force

git pull --rebase origin master

git rebase origin/master
git rebase -i --autosquash -Xtheirs main

# Восстанавливаем ветку из репозитори
git fetch --all
git reset --hard origin/master

# Skip smudge - We'll download binary files later in a faster batch
git lfs install --skip-smudge
git clone ...
git lfs pull
git lfs install --force

git push --delete origin 0.0.0-test
git tag -d 0.0.0-test
git push --delete origin v1.0.50

# [404] Object does not exist on the server
git lfs fetch --all
git lfs push --object-id origin  d7c1f12688e8cc55a7efca62e2b3dfa7cf5a1025b4064b8e0f0bba093c782ac0


### git lfs fix
```
git clone "git@github.com:Test/Repo" --quiet;
cd -- "Repo";
git fetch --append --prune --quiet;
cp /tmp/00000097/Repo/file.pth ./
git lfs track file.pth
git add .gitattributes
git add file.pth
git commit -m "initial commit"
git push -u origin master
```

# gui git linux
gitg

## unpopulated

error:
```
fatal: in unpopulated submodule 'crosscompile/conan/examples'
```

```
git rm --cached crosscompile/conan/examples -f
```

#### склеиваем комиты
```
git cherry -v master
git cherry -v master | wc -l
git rebase -i --autosquash HEAD~4
```

# Russian sumbol
git config --global core.quotepath false
export LANG='C.UTF-8'


# creat pull pull-request
hub pull-request -b main

- Learn how to rewrite Git history - Amend, Reword, Delete, Reorder, Squash and Split
https://www.youtube.com/watch?v=ElRzTuYln0M

# добавить еще файлов к последнему сделанному комиту без изменения комментария коммиат
git commit --amend --no-edit
git stash -m "comment"
git stash pop --index 1
# создадим ветку из стеша с индексом 1
git stash branch NameBranch 1
git stash drop stash@{0}
# delete all stash
git stash clear
