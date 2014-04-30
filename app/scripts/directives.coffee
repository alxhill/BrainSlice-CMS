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
            list.push parseFloat value.trim()
      return list

    ctrl.$formatters.push (value) ->
      if angular.isArray(value)
        return value.join ', '

.directive 'sticky', ($window) ->
  link: (scope, elem, attrs) ->
    console.log(arguments)
    elemPos = elem.offset().top
    $($window).scroll ->
      if elemPos < $window.scrollY
        unless elem.hasClass("sticky-fixed")
          elem.addClass("sticky-fixed")
      else
        elem.removeClass("sticky-fixed")
