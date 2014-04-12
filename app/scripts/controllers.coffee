'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$resource'
  '$rootScope'

($scope, $location, $resource, $rootScope) ->
    $rootScope.pageTitle = "BrainSlice CMS"

    $scope.form = {}

    $scope.segments =
        frontal:
            id: "frontal"
            name: "Frontal Lobe"
            description: "The frontal lobe is boring"
        cerebellum:
            id: "cerebellum"
            name: "Cerebellum"
            description: "The cerebellum does some magic"

    $scope.edit = (id) ->
        $scope.editing = true
        $scope.form.segment = angular.copy($scope.segments[id])
        $scope.form.id = id

    $scope.save = (id) ->
        $scope.segments[id] = angular.copy($scope.form.segment)
        # code to save to the server will go here

])
