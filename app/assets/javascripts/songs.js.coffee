$ ->
  $("#transpose").change ->
    window.location.search = "?transpose=#{$(this).val()}"
