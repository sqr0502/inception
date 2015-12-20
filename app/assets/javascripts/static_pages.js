// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

var app = angular.module('inception', ['ngAnimate']);

app.controller('formController', ['$scope', '$http', function($scope, $http){

  $scope.user = {};

  // create a new submission after initial submission
  $scope.newSubmission = function(){
    $scope.done = false;

    // clears model (form) once form has been completed
    $scope.user = {};
    // reset ratings
    $scope.ratings.map(function(rating){rating.rating = 0;});
    // reset form after initial submission
    $scope.myForm.$setUntouched();
  }

  $scope.addUser = function(){

    $scope.user.ratings = $scope.ratings;
      if($scope.user.full_name && $scope.user.email && $scope.user.project_repo && $scope.user.project_url){
        $http.post('/api/user', $scope.user).then(function(res){
          if(res.status == 200){
                console.log('sucessful');
                $scope.done = true;

                // clears model (form) once form has been completed
                // $scope.user = {};
                // $scope.ratings.map(function(rating){rating.rating = 0;});
          }
      });
  }else{
    $scope.invalid = true;
  }
}

  $scope.url = function(param){
    if($scope.user[param].indexOf('http') < 0 ){
      $scope.user[param] = 'http://' + $scope.user[param];
    }
  }



  $scope.tally = 0;
  $scope.updateRating = function(rating){
    $scope.tally += rating;
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
