class TodoList.Collections.Tasks extends Backbone.Collection
  url: '/tasks'
  model: TodoList.Models.Task

  # comparator: (task) =>
  	# task.get('priority')
  
  #//localStorage: -> new Store('tasks')
