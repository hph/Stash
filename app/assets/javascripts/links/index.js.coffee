$ ->
  getUid = (el) ->
    if el.hasClass 'list-group-item'
      return el.data 'uid'
    else
      return el.parent('.list-group-item').data 'uid'

  $('.list-group-item').click (event) ->
    uid = getUid($ event.target)
    if $(event.target).hasClass 'edit-link-button'
      window.location = "/links/#{uid}"
    else
      window.location = "/#{uid}"
