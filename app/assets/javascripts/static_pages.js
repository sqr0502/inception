// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var app = angular.module('inception', []);

app.controller('formController', ['$scope', '$http', function($scope, $http){
  console.log('this works');

  $scope.addUser = function(){

    $scope.user.ratings = $scope.ratings;

    $http.post('/api/user', $scope.user).then(function(res){
      if(res.status == 200){
            console.log('sucessful');
      }
    })
  }

  $scope.ratings = [{
    name: "use best practices for OOP",
    rating: 0
  }, {
    name: "modular development",
    rating: 0,
  }, {
    name: "full stack workflow understanding",
    rating: 0
  }, {
    name: "testing",
    rating: 0
  }, {
    name: "database knowledge",
    rating: 0
  }, {
    name: "debugging",
    rating: 0
  }, {
    name: "problem solving skills",
    rating: 0
  }, {
    name: "javascript",
    rating: 0
  }, {
    name: "html",
    rating: 0
  }, {
    name: "css",
    rating: 0
  }, {
    name: "working on a team",
    rating: 0
  }, {
    name: "self-motivation",
    rating: 0
  }, {
    name: "communication skills",
    rating: 0
  }, {
    name: "your own energy level",
    rating: 0
  }, {
    name: "intelligence",
    rating: 0
  }]
}]);
