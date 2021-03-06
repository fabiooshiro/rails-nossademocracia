'use strict';

var app = angular.module('app');
app.factory('Forum', ['$resource', function($resource) {
    return $resource('/forums/:id', {id: '@id'});
}]);

app.factory('Comment', ['$resource', function($resource) {
    return $resource('/forums/:forumId/comments/:id', {forumId: '@forumId', id: '@id'});
}]);

app.factory('Projeto', ['$resource', function($resource) {
    return $resource('/projetos/:id', {id: '@id'});
}]);

app.factory('Voto', ['$resource', function($resource) {
    return $resource('/votos/:id', {id: '@id'});
}]);

app.factory('User', ['$resource', function($resource) {
    return $resource('/users/:id', {id: '@id'}, {update: {method: 'PUT'}});
}]);
