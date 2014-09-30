$(".users.link").ready ->

  $(document).ajaxSuccess ->
      $('#new_link_form').find('input[type="text"]').val('')
  $(document).ajaxError ->
