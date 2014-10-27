$ ->
  getUid = (el) ->
    if el.hasClass 'tag'
      return null
    if el.hasClass 'list-group-item'
      return el.data 'uid'
    else
      return el.parent('.list-group-item').data 'uid'

  $('.list-group-item').click (event) ->
    target = $ event.target
    uid = getUid target
    if uid == null
      window.location = "/tags/#{target.html()}"
    else if $(event.target).hasClass 'edit-link-button'
      window.location = "/links/#{uid}"
    else
      window.location = "/#{uid}"
