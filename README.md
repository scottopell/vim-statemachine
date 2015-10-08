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

