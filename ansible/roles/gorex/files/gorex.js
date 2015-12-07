"use strict";

angular.module('gorex', []);

angular.module('gorex').factory('Rex', function($http){
	return {
		eval: function(re, inputs) {
			return $http.post('/eval', {
				re: re,
				inputs: inputs
			});
		}
	};
});

angular.module('gorex').controller('RexController', function($scope, Rex){
	$scope.inputs = [{v:''}];
	
	$scope.addInput = function() {
		$scope.inputs.push({v:''});
		$scope.rex();
	};

	$scope.delInput = function(index) {
		$scope.inputs.splice(index, 1);
		$scope.rex();
	};

	$scope.rex = function() {
		var inputs = []
		for(var i=0;i<$scope.inputs.length; i++) {
			inputs.push($scope.inputs[i].v)
		}
		Rex.eval($scope.re, inputs)
			.success(function(data){
				console.log(data)
				delete $scope.error;
				$scope.data=data;
			})
			.error(function(msg, code){
				delete $scope.data;
				$scope.error=msg;
			});
	}
});
