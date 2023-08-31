# debug regexp
https://www.debuggex.com/

# 850-555-1234
^[0-9]{3}-[0-9]{3}-[0-9]{3}$

# все кроме этих символом
[^0-9]

# bob.smith@mail.org
^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$
^[a-zA-Z\d._]+@[a-zA-Z\d]+\.[a-zA-Z]{2,3}$
^[\w\d._]+@[\w\d]+\.[\w]{2,3}$
