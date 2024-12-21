- https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/chain-of-thought

- попросить его разбить задачу на шаги чтобы наверняка выполнить задачу и потом следовать этим шагам и затем дать ответ исходя из рассуждений

- prompt:
```
how many r's are there in the word strawberry?

First write how you would break this problem down into what steps to be sure to solve it correctly
Then follow your steps and complete them.
And give the answer based on the steps of reasoning
```

- output:
```
Here's how I would break down the problem and solve it:
Steps to solve the problem:

Write out the word "strawberry"
Go through each letter one by one
Count the occurrences of the letter 'r'
Report the final count

Now, let's follow these steps:

Write out the word: strawberry
Go through each letter:
s - not an r
t - not an r
r - first r (count: 1)
a - not an r
w - not an r
b - not an r
e - not an r
r - second r (count: 2)
r - third r (count: 3)
y - not an r
Final count: 3

Based on these steps of reasoning, the answer is that there are 3 r's in the word "strawberry".
```

```
Если у тебя не достаточно информации спроси у меня дополнительную информацию, но не делай наугад и не городи костыли.

Если нужно добавь логи. Если логина на фронтенде до делай через strigify
Если у тебя не достаточно информации чтобы решить проблему качественно, запроси у меня дополнительную информацию.
Если я предоставил не то что нужно, тоже скажи.
```
