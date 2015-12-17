// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var app = angular.module('inception', []);

app.controller('formController', ['$scope', '$http', function($scope, $http){
  console.log('this works');

  $scope.addUser = function(){
    $http.post('/api/user', $scope.user).then(function(res){
      if(res.status == 200){
            console.log('sucessful');
      }
    })
  }
}]);
