window.TodoList =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new TodoList.Routers.Tasks
    Backbone.history.start()

$(document).ready ->
  TodoList.initialize()
