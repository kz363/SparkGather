$(".users.link").ready ->

  clip = new ZeroClipboard($('#copy-button'))

  generatedLink = $('#generated_link')

  $('#copy-button').on 'click', (e) ->
    e.preventDefault()
    generatedLink.select()

  $(document).ajaxSuccess ->
      $('#new_link_form').find('input[type="text"]').val('')

      generatedLink.select()
  $(document).ajaxError ->
