# Hireme

## Developing

### Install CoffeScript
```bash
$ npm install -g coffee-script
```

### Install UglifyJS
```bash
$ npm install -g uglify-js
```

### Compile CoffeeScript into a single file and minify
```bash
$ coffee -p -c coffee/*.coffee | uglifyjs > public/js/application.js
```
