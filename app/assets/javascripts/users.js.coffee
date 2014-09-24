# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $window = $(window)
  console.log("Screen Resolution: #{screen.width} x #{screen.height}")
  console.log("Window Size: #{$window.width()} x #{$window.height()}")
  console.log("HTML 5 Support? #{Modernizr.canvas}")
  console.log("CSS 3 Support? #{Modernizr.borderradius}")
  plugins = ( "#{plugin.name} #{plugin.description}" for plugin in navigator.plugins)
  window.plugins = plugins
  flash_version = flash for flash in plugins when flash.match /Shockwave/
  # console.log(flash_version)
  # console.log("Flash Version: #{flash_version}")
  user_id = $('#user_id').text()
  user_ip_address = $('#user_ip_address').text()
  # console.log(user_id)
  audio = Modernizr.audio
  video = Modernizr.video
  audio_formats = "ogg: #{audio.ogg}, wav: #{audio.wav}, m4a: #{audio.m4a}"
  video_formats = "ogg: #{video.ogg}, h264: #{video.h264}, webm: #{video.webm}"
  cookies = navigator.cookieEnabled

  update_info = ->
    $.ajax '/update',
      method: 'POST'
      data:
        user_info:
          id: user_id
          screen_resolution: "#{screen.width} x #{screen.height}"
          window_size: "#{$window.width()} x #{$window.height()}"
          html5_support: "#{Modernizr.canvas}"
          css3_support: "#{Modernizr.borderradius}"
          flash_version: flash_version
          audio_formats: audio_formats
          video_formats: video_formats
          cookies: cookies

  update_info()
