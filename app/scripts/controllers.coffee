'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$http'
  '$rootScope'

($scope, $location, $http, $rootScope) ->
    $rootScope.pageTitle = "BrainSlice CMS"

    $scope.form = {}
    $scope.form.buttonText = "Save"

    $http.get("/api/all").success (data) ->
        $scope.segments = data


    $scope.edit = (id) ->
        $scope.editing = true
        $scope.form.segment = angular.copy($scope.segments[id])
        $scope.form.id = id
        $scope.form.buttonText = "Save"

    $scope.save = (id) ->
        $scope.segments[id] = angular.copy($scope.form.segment)
        $http.post("/api/segment/#{id}", $scope.segments[id]).success (data) ->
            console.log data
            if data.success
                $scope.form.buttonText = "Saved!"
            else
                alert("There was an error saving your changes. Please refresh and try again.")
])
