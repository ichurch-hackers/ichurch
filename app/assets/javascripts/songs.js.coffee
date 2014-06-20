Turbolinks.enableTransitionCache()

$(document).on "ready page:load", ->
  $("#transpose").change ->
    Turbolinks.visit([window.location.origin, window.location.pathname, "?transpose=#{$(this).val()}"].join(""))
