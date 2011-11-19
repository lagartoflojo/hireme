$ ->
  $('#search').submit (e)->
    e.preventDefault()
    window.location = "/#{$('#github-username').val()}"
