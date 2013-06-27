'use strict';

var app = angular.module('app');

function chkUserLogin(){
    if(!window.user){
        alert("Para isso vc precisa estar logado no facebook.");
        return false;
    }
    return true;
}

app.controller('UserShowController', ['$scope', '$location', '$routeParams', 'User', function($scope, $location, $routeParams, User) {

	$scope.user = User.get({id: $routeParams.id});

    //The save method which is called when the user wants to submit their data
    $scope.save = function() {
        if(!chkUserLogin()) return;
        window.user['parent_id'] = $scope.user.parent_id;
        var user = new User(window.user);

        //Save the forum object
        user.$update(function() {

            //Redirect us back to the main page
            $location.path('/projetos');

        }, function(response) {

            //Post response objects to the view
            $scope.errors = response.data.errors;
        });
    }
}]);
