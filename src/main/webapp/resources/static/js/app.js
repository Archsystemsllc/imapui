'use strict';

var App = angular.module('myApp',[]);

(function() {
	console.log("*************************************************: Start");
  var initInjector = angular.injector(['ng']);
  var $http = initInjector.get('$http');
  $http.get('config.json').then(
    function (response) {
    console.log("*************************************************:"+response.data.restUrl);
    
    App.constant('configData', response.data);
    	  
        console.log("done!!")
    }
  );
  console.log("*************************************************: End");
})();

App.provider('configDataProvider', ['configData', function(configData) {	
	this.data = configData;
	  this.$get = function() {
	    return this.data;
	  };
}]);
