# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $("card")
    .addClass("ui-widget ui-widget-content ui-corner-all")
    .find("header").addClass("ui-widget-header")
    .end()
