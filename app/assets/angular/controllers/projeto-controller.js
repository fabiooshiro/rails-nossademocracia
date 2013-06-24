'use strict';

var app = angular.module('app');

function chkUserLogin(){
    if(!window.user){
        alert("Vc precisa estar logado no facebook para postar um projeto.");
        return false;
    }
    return true;
}

app.controller('ProjetoIndexController', ['$scope', 'Projeto', function($scope, Projeto) {
    //Grab all forums from the server
    $scope.items = Projeto.query();

    //Destroy method for deleting a forum
    $scope.destroy = function(index) {

        if(!chkUserLogin()) return;

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

        if(!chkUserLogin()) return;

        //Create the forum object to send to the back-end
        $scope.projeto.user = window.user;
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
app.controller('ProjetoShowController', ['$scope', 'Projeto', 'Voto', '$routeParams', function($scope, Projeto, Voto, $routeParams) {

    function showResumo(domain){
        $scope.total = {sim: 0, nao: 0};
        $.each(domain.resumo, function(i, item){
            $scope.total[item.valor] = item.total;
        });
    }

    $scope.total = {sim: '?', nao: '?'};

    //Grab the projeto from the server
    $scope.projeto = Projeto.get({id: $routeParams.id}, function(){
        showResumo($scope.projeto);
    });
    
    function votar(valor){
        var voto = new Voto();
        voto.user = window.user;
        voto.valor = valor;
        voto.projeto = $scope.projeto;
        voto.$save(function (response){
            // ok
            showResumo(response);
        }, function(response){
            // errors
        });
    }

    $scope.votarSim = function(){
        if(!chkUserLogin()) return;
        votar('sim');
    }

    $scope.votarNao = function(){
        if(!chkUserLogin()) return;
        votar('nao');
    }
}]);
