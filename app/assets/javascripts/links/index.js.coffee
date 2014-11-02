$ ->
  getUid = (el) ->
    if el.hasClass 'tag'
      return null
    if el.hasClass 'list-group-item'
      return el.data 'uid'
    else
      return el.parent('.list-group-item').data 'uid'

  set_star = (target) ->
    target.removeClass 'fa-star-o'
    target.addClass 'fa-star'
    'favourites'

  unset_star = (target) ->
    target.removeClass 'fa-star'
    target.addClass 'fa-star-o'
    null

  set_clock = (target) ->
    target.removeClass 'fa-circle-o'
    target.addClass 'fa-clock-o'
    'unread'

  unset_clock = (target) ->
    target.removeClass 'fa-clock-o'
    target.addClass 'fa-circle-o'
    null

  toggle = (target) ->
    if target.hasClass 'fa-star-o'
      unset_clock target.siblings('i.toggle')
      set_star target
    else if target.hasClass 'fa-star'
      unset_star target
    else if target.hasClass 'fa-circle-o'
      unset_star target.siblings('i.toggle')
      set_clock target
    else
      unset_clock target

  mark = (target, uid) ->
    category = toggle target
    $.ajax
      url: "/links/#{uid}"
      type: 'PUT'
      data: {link: {category: category}}

  $('.list-group-item').click (event) ->
    target = $ event.target
    uid = getUid target
    if uid == null
      window.location = "/tags/#{target.html()}"
    else if target.hasClass 'favourite-button'
      mark target, uid
    else if target.hasClass 'read-later-button'
      mark target, uid
    else if target.hasClass 'edit-link-button'
      window.location = "/links/#{uid}"
    else
      window.location = "/#{uid}"
