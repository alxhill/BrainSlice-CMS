'use strict'

### Controllers ###

angular.module('app.controllers', [])

.controller('AppCtrl', [
  '$scope'
  '$location'
  '$http'
  '$rootScope'
  '$timeout'
($scope, $location, $http, $rootScope, $timeout) ->
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
        segment = $scope.form.segment
        if angular.isArray segment.position
            if segment.position.length != 3
                alert "position must have exactly 3 elements"
                return
        else
            segment.position = null

        segment.tasks ?= []

        $scope.segments[id] = angular.copy(segment)
        $http.post("/api/segment/#{id}", $scope.segments[id]).success (data) ->
            console.log data
            if data.success
                $scope.form.buttonText = "Saved!"
                $timeout ->
                    $scope.form.buttonText = "Save"
                , 1000
            else
                alert("There was an error saving your changes. Please refresh and try again.")
])
