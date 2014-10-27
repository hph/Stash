$ ->
  uid = $('.link').data 'uid'

  $('#delete-link').click (event) ->
    $.ajax
      url: "/links/#{uid}",
      type: 'DELETE',
      success: (response) ->
        window.location = '/'

  $('#update-link').click (event) ->
    data =
      link:
        url: $('input[name="url"]').val()
        name: $('input[name="name"]').val()
        tags: $('input[name="tags"]').val()
    $.ajax
      url: "/links/#{uid}"
      type: 'PUT'
      data: data
      success: (response) ->
        window.location = '/'
