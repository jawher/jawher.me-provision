"use strict";

angular.module('gorex', []);

angular.module('gorex').factory('Rex', function($http){
	return {
		eval: function(re, input) {
			return $http.post('/eval', {
				re: re,
				input: input
			});
		}
	};
});

angular.module('gorex').controller('RexController', function($scope, Rex){
	$scope.rex = function() {
		Rex.eval($scope.re, $scope.input)
			.success(function(data){
				delete $scope.error;
				$scope.data=data;
			})
			.error(function(msg, code){
				delete $scope.data;
				$scope.error=msg;
			})
	}
});
