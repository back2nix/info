npm install
npm run dev
npm run build

# production
npm run build --report

npm init
npm run serve

# hello world websocket
https://blog.anoff.io/2018-04-18-node-vue-websockets/

npm install vue-socket.io@2.1.1-b --save


# flask + vue
https://smyt.ru/blog/flask-webpack-vuejs/

# websocket
https://github.com/miguelgrinberg/Flask-SocketIO/tree/master/example
# vue flask
https://github.com/oleg-agapov/flask-vue-spa


# watch
#### package.json
```js
"watch": "vue-cli-service build --watch --mode development" 
```
#### vue.config.js
```js
module.exports = {
  outputDir: '../dist/resources/',
  assetsDir: '../',
}
```

# Vuetify — A Material Design Framework for vue
https://vuetifyjs.com/en/

#### foreceUpdate

- https://michaelnthiessen.com/force-re-render/

```
// Globally
import Vue from 'vue';
Vue.forceUpdate();

// Using the component instance
export default {
  methods: {
    methodThatForcesUpdate() {
      // ...
      this.$forceUpdate();  // Notice we have to use a $ here
      // ...
    }
  }
}
```
