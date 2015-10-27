Statemachine DSL example vim plugin

## Getting up and running
- Clone this repo
- Clone XText
- In one terminal, cd to your xtext directory and run `./gradlew jettyRun`
- Test that your example webserver is running by going to http://localhost:8080
- Add this vim plugin via your favorite package manager
- Open `example.statemachine` in vim
- Celebrate

### `./gradlew jettyRun`
One of the assets downloaded during this process may fail, if you google the
filename you can find a new url for this file.

### Adding this plugin from a package manager

Examples for some popular plugin managers
```vimscript
" plug
"  dev mode
Plug '~/code/vim-statemachine'
"  production
Plug 'scottopell/vim-statemachine'
```

## XText Wrappers
![example_usages.png]

### Validator.rb

*Usage:*
```shell
$ ./validator.rb example.sm
```

This will return errors to you in the following format

```
<line>: <description>
<line>: <description>
<line>: <description>
```

An example errorformat would be `'%l: %m'` where `%l` is line # and `%m` is
the error message.

### complete.rb

*Usage:*
```shell
# File offset
$ ./complete.rb example.sm 5
# OR
# line and column
$ ./complete.rb example.sm 2 6
```

This will return a list of possible code completions from this point.
You can pass it either an offset into the file as a character count or a
row and column pair.

```
<token>
<othertoken>
<thirdtoken>
```

### formatter.sh

*Usage:*
```shell
$ cat example.sm | ./formatter.sh
```

This will format the code for you and print out the formatted code.
