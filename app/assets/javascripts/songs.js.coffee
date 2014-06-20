Turbolinks.enableTransitionCache()

$(document).on "ready page:load", ->
  $("#transpose").change ->
    Turbolinks.visit("?transpose=#{$(this).val()}")
