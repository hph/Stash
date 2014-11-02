$ ->
  $('.help').popover()

  uid = $('.link').data 'uid'

  $('#delete-link').click (event) ->
    $.ajax
      url: "/links/#{uid}",
      type: 'DELETE',
      success: (response) ->
        window.location = '/'

  $('#update-link').click (event) ->
    category = $('select[name="category"]').children('option:selected').val()
    if category != 'favourites' && category != 'unread'
      category = null
    data =
      link:
        url: $('input[name="url"]').val()
        name: $('input[name="name"]').val()
        tags: $('input[name="tags"]').val()
        category: category
        public: $('input[name="public"]').prop('checked')
    $.ajax
      url: "/links/#{uid}"
      type: 'PUT'
      data: data
      success: (response) ->
        window.location = '/'
