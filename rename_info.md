####

- Удалить только четные

ls | grep -E "([0,2,4,6,8].png)" | xargs rm -rf

rename -n -v 's/(\d+)/($1 + 1)/e' *

mmv "*.png" "#1.png"

```
for file in *.txt
do
  mv "$file" "new_name"
done
```
