$(".users.link").ready ->

  clip = new ZeroClipboard($('#copy-button'))

  generatedLink = $('#generated_link')

  $('#copy-button').on 'click', (e) ->
    e.preventDefault()
    generatedLink.select()

  $('#new_link_form')
    .bind 'ajax:success', (event, data, status, xhr) ->
      $('#new_link_form').find('input[type="text"]').val('')
      $( "#generated_link_div" ).removeClass('hidden')
      generatedLink.val(data.url)
      generatedLink.select()

    .bind 'ajax:error', (event, data, status, xhr) ->
      alert 'Internet is broken :('
