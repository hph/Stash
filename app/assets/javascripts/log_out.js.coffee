($ '#log-out').on 'click', ->
  $.ajax
    url: App.sign_out_path
    type: 'DELETE'
    success: -> window.location = '/'
