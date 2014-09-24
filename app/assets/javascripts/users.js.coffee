# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	setupView = ->
	update_info = ->
		$.ajax '/update',
      	method: 'PUT'
      	data:
		user_id: user_id
      	  user_info: user_info
      	  success: (e) ->
      	    show complete!

	setupView()

 	$window = $(window)
 	plugins = ( "#{plugin.name} #{plugin.description}" for plugin in navigator.plugins)
 	window.plugins = plugins
 	flash_version = flash for flash in plugins when flash.match /Shockwave/
 	user_id = parseInt($('#user_id').text())
 	user_ip_address = $('#user_ip_address').text()
 	audio = Modernizr.audio
 	video = Modernizr.video
 	audio_formats = "ogg: #{audio.ogg}, wav: #{audio.wav}, m4a: #{audio.m4a}"
 	video_formats = "ogg: #{video.ogg}, h264: #{video.h264}, webm: #{video.webm}"
 	cookies = navigator.cookieEnabled

  	user_info =
  	  screen_resolution: "#{screen.width} x #{screen.height}"
  	  window_size: "#{$window.width()} x #{$window.height()}"
  	  html5_support: Modernizr.canvas
  	  css3_support: Modernizr.borderradius
  	  flash_version: flash_version
  	  audio_formats: audio_formats
  	  video_formats: video_formats
  	  cookies: cookies
  	  plugins: plugins.join(', ')
  	  javascript: true

  	update_info()
