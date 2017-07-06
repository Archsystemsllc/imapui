'use strict';
angular.module('myApp').value('config', {
	  api: ''
	});
angular.module('myApp').controller('ReportingController',['$scope', 'ReportingService', function($scope, ReportingService) {
    var self = this;
    self.dataAnalysis={id:null,dataAnalysisDescription:'',dataAnalysisName:''};
    self.dataAnalysis=[];
        

    
   // dataAnalysisOptions();
    
    
   
    function dataAnalysisOptions(){
    	//console.log("api::"+config.api)
    	ReportingService.dataAnalysisOptions()
            .then(
            function(d) {
                self.dataAnalysis = d;
            },
            function(errResponse){
                console.error('Error while fetching data analysis options');
            }
        );
    }  
}]);

angular.module('myApp').run(function($rootScope, $http, config) {
	console.log("*************ffffffffffffffffffffff*****************")
	  $http.get('"http://localhost:8080/imapui/imapServicesApi').then(function(response) {
		  console.log("responsssssssssssssssssssssse::"+response)
	        config.api = response;
	        $rootScope.$broadcast('config-loaded');
	    });
	});