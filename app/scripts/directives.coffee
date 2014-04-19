'use strict'

### Directives ###

# register the module with Angular
angular.module('app.directives', [
  # require the 'app.service' module
  'app.services'
])

.directive 'numList', ->
  require: 'ngModel'
  link: (scope, elem, attr, ctrl) ->

    ctrl.$parsers.push (viewValue) ->
      list = []
      if viewValue?
        for value in viewValue.split ","
          if value?
            list.push(+value) # converts the value into an integer
      return list

    ctrl.$formatters.push (value) ->
      if angular.isArray(value)
        return value.join ', '
