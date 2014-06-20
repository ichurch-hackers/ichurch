$(document).on "ready page:load", ->
  $("#transpose").change ->
    window.location.search = "?transpose=#{$(this).val()}"
