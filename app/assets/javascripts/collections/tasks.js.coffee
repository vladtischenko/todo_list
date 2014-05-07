class TodoList.Collections.Tasks extends Backbone.Collection
  url: '/tasks'
  model: TodoList.Models.Task

  #//localStorage: -> new Store('tasks')
