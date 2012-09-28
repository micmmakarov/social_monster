# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(document).on "keyup", ".friends_finder", ($.debounce 250, ->
    value = $(this).val().toUpperCase()
    $(".friends_list .friend").each ->
      name = $(this).attr("data-friend-name").toUpperCase()
      if name.match(value)
        $(this).show(500)
      else
        $(this).hide(500)
  )
  $(document).on "click", ".friend", ->
    f = $(this)
    $(".announce_list").append(f)
    $(this).destroy
  $(document).on "click", ".send_announce", ->
    data = new Array()
    $(".announce_list .friend").each ->
      friend_name = $(this).attr("data-friend-name")
      friend_id = $(this).attr("data-friend-id")
      data.push(friend_id)
    dataToSend = {'data': data}
    $.ajax
      type: "POST"
      dataType: 'array'
      url: "http://somewhere.on.the.web"
      data: dataToSend
      success: ->
        alert ("Fucken Yey!")
      error: ->
        alert("Something went wrong")
