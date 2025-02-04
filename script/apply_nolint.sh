#!/bin/bash
# Скрипт для автоматического добавления комментариев nolint в исходных файлах
# с ошибками линтера, используя файлы с описаниями ошибок.
#
# Использование: ./apply_nolint.sh [errors_file]
# Если параметр не задан, по умолчанию используется файл errors.txt.

set -euo pipefail

# Файл с ошибками; по умолчанию errors.txt
ERRFILE="${1:-errors.txt}"

if [[ ! -f "$ERRFILE" ]]; then
  echo "Ошибка: Файл '$ERRFILE' не найден."
  exit 1
fi

# Массив для ключей в формате "файл:номер_строки" и соответствующий массив с линтерами
keys=()
values=()

# Читаем файл ошибок построчно
while IFS= read -r err_line; do
  # Ожидаемый формат:
  # путь/до/файла.go:номер:колонка: описание ошибки (линтер)
  # Пример:
  # internal/modules/identity/identity_test.go:19:14: printf: non-constant format string in call to (*testing.common).Errorf (govet)
  if [[ "$err_line" =~ ^([^:]+):([0-9]+):[0-9]+:.*\(([a-zA-Z0-9_-]+)\)$ ]]; then
    file="${BASH_REMATCH[1]}"
    line_no="${BASH_REMATCH[2]}"
    linter="${BASH_REMATCH[3]}"
    key="${file}:${line_no}"

    # Проверяем, существует ли уже этот ключ
    found=0
    for i in "${!keys[@]}"; do
      if [[ "${keys[$i]}" == "$key" ]]; then
        # Если этот линтер ещё не добавлен для данной строки, добавляем его через запятую
        if [[ ",${values[$i]}," != *",$linter,"* ]]; then
          values[$i]="${values[$i]},$linter"
        fi
        found=1
        break
      fi
    done

    # Если ключа еще нет в списке, добавляем новый
    if [[ $found -eq 0 ]]; then
      keys+=("$key")
      values+=("$linter")
    fi
  fi
done <"$ERRFILE"

# Обработка исходных файлов: добавление комментария //nolint в конец указанных строк.
for i in "${!keys[@]}"; do
  key="${keys[$i]}"
  linter_list="${values[$i]}"
  file="${key%%:*}"
  line_no="${key##*:}"

  if [[ ! -f "$file" ]]; then
    echo "Предупреждение: Файл '$file' не найден. Пропуск."
    continue
  fi

  # Получаем содержимое нужной строки
  current_line=$(sed -n "${line_no}p" "$file")

  # Если строка уже содержит комментарий nolint, пропускаем её
  if [[ "$current_line" == *"//nolint:"* ]]; then
    echo "Пропущено $file:$line_no (уже содержит nolint)"
    continue
  fi

  # Для macOS sed нужно указать пустую строку для расширения резервной копии
  sed -i "" "${line_no}s/\$/  \/\/nolint:${linter_list}/" "$file"
  echo "Обновлён $file:$line_no с '//nolint:${linter_list}'"
done
