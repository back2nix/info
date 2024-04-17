# sudo libtoolize && sudo aclocal && sudo autoheader && sudo autoconf && sudo automake --add-missing

```bash
libtoolize &&
	aclocal &&
	autoheader &&
	autoconf &&
	automake --add-missing

aclocal  # Set up an m4 environment
autoconf # Generate configure from configure.ac
automake
automake --add-missing # Generate Makefile.in from Makefile.am
./configure            # Generate Makefile from Makefile.in
make                   # distcheck # Use Makefile to build and test a tarball to distribute
```

```bash
ifeq (mycommand,$(firstword $(MAKECMDGOALS)))
  myargs := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(competitor):;@:)
endif

.PHONY: mycommand
mycommand:
    @myscript.sh ${myargs}
```
