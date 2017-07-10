'use strict';

angular.module('myApp').factory('ReportingService', ['$http', '$q', function($http, $q){

    var REST_SERVICE_URI = 'http://localhost:8080/imapservices/api/';

    var factory = {
    		dataAnalysisOptions: dataAnalysisOptions,
    		serviceApiEndpoint:serviceApiEndpoint
    };

    return factory;

    function dataAnalysisOptions(serviceApiEndpoint) {
        var deferred = $q.defer();
        $http.get(serviceApiEndpoint+"dataanalysis")
            .then(
            function (response) {
            	console.log("**********:"+JSON.stringify(response.data))
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while fetching data analysis options');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }
    
    function serviceApiEndpoint(){
    	var deferred = $q.defer();
        $http.get("http://localhost:8080/imapui/imapServicesApi")
            .then(
            function (response) {
            	console.log("**********:"+JSON.stringify(response.data))
                deferred.resolve(response.data);
            },
            function(errResponse){
                console.error('Error while fetching data end point');
                deferred.reject(errResponse);
            }
        );
        return deferred.promise;
    }

 
}]);
