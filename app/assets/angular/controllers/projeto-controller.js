'use strict';

var app = angular.module('app');

app.controller('ProjetoIndexController', ['$scope', 'Projeto', function($scope, Projeto) {
    //Grab all forums from the server
    $scope.items = Projeto.query();

    //Destroy method for deleting a forum
    $scope.destroy = function(index) {

        //Tell the server to remove the object
        Projeto.remove({id: $scope.items[index].id}, function() {
            //If successful, remove it from our collection
            $scope.items.splice(index, 1);
        });
    }
}]);

app.controller('ProjetoCreateController', ['$scope', '$location', 'Projeto', function($scope, $location, Projeto) {
    //The save method which is called when the user wants to submit their data
    $scope.save = function() {

        //Create the forum object to send to the back-end
        var projeto = new Projeto($scope.projeto);

        //Save the forum object
        projeto.$save(function() {

            //Redirect us back to the main page
            $location.path('/projetos');

        }, function(response) {

            //Post response objects to the view
            $scope.errors = response.data.errors;
        });
    }
}]);

//A controller to show the forum and all it's glory
app.controller('ProjetoShowController', ['$scope', 'Projeto', 'Comment', '$routeParams', function($scope, Projeto, Comment, $routeParams) {
    //Grab the forum from the server
    $scope.projeto = Projeto.get({id: $routeParams.id})
}]);
