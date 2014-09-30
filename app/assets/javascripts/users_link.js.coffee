$(".users.link").ready ->

  clip = new ZeroClipboard($('#copy-button'))

  $(document).ajaxSuccess ->
      $('#new_link_form').find('input[type="text"]').val('')
      $('#generated_link').select()
  $(document).ajaxError ->
