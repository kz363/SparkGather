$(".users.gather").ready ->

	showMsg = (msg) ->
		$('#main-content').empty()
		$('#main-content').append(msg)

	showLoading = ->
		# replace current page with gif
		loadingStatus = ''
		text = 'Please wait... '
		img = "<img src='/assets/gs-loader.gif' alt='loading..'>"
		loadingStatus += text
		loadingStatus += img
		showMsg(loadingStatus)

	showSuccess = ->
		# replace current page with success message
		successMsg = "Done! You're all set. Please feel free to close this window."
		showMsg(successMsg)

	showError = ->
		# replace current page with success message
		errorMsg = 'Uhoh! Something went wrong. Please reload the page and try again. Sorry.'
		showMsg(errorMsg)

	renderShowPage = (response) ->
		# replace current page with collected user data
		$('#container').empty()
		$('#container').append(response)

	speed_test = ->
		$.ajax '/speedtest',
			method: 'GET'

	update_info = ->
		$.ajax '/update',
			method: 'PUT'
			data:
				user_id: user_id
				user_info: user_info
			error: ->
				showError()
			success: (response) ->
				renderShowPage(response)

	showLoading()

	$window = $(window)
	debugger;
	plugins = ( "#{plugin.name}:: #{plugin.description}" for plugin in navigator.plugins )
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
		plugins: plugins.join('; ')
		javascript: true

	start = new Date().getTime()
	test = speed_test()
	test.done (data) ->
		end = new Date().getTime()
		size = parseInt(test.getResponseHeader('Content-Length'), 10) / 1000
		user_info.download_speed = Math.round((size / ((end - start) / 1000)) * 10) / 10 + " KB/s";
		update_info()
