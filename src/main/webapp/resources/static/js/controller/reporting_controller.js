'use strict';
angular.module('myApp').controller('DemoController', ["configData", function DemoController(configData) {
	  this.configData = configData;
	  
	}]);
angular.module('myApp').controller('ReportingController', ['configData', 'ReportingService', function(configData, ReportingService) {
    var self = this;
    self.dataAnalysis={id:null,dataAnalysisDescription:'',dataAnalysisName:''};
    self.dataAnalysis=[];
    this.configData = configData;
   
    dataAnalysisOptions();

    function dataAnalysisOptions(){
    	ReportingService.dataAnalysisOptions(configData)
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
