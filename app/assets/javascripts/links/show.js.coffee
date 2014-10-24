$ ->
  uid = $('.link').data 'uid'

  $('#delete').click (event) ->
    $.ajax
      url: "/links/#{uid}",
      type: 'DELETE',
      success: (response) ->
        window.location = '/'

  $('#update').click (event) ->
    data =
      link:
        url: $('input[name="url"]').val()
        name: $('input[name="name"]').val()
    $.ajax
      url: "/links/#{uid}"
      type: 'PUT'
      data: data
      success: (response) ->
        window.location = '/'
