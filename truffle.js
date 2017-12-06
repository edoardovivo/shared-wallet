// Allows us to use ES6 in our migrations and tests.
require('babel-register')

module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*' // Match any network id
    }
  },

  "app.js" : [
  	"bower_components/angular/angular.js",
  	"bower_components/angular_route/angular_route.js",
  	"javascripts/app.js"
  ]
}
