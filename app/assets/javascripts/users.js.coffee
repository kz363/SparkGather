# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

	toggleInfo = (e) ->
		e.preventDefault()
		$collapse = $(@).closest('.collapse-group').find('.collapse')
		$collapse.collapse('toggle')

	$('.record').click toggleInfo
