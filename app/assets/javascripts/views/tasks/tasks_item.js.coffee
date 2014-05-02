class TodoList.Views.TasksItem extends Backbone.View
  template: JST['tasks/item']
  events:
    'click a.remove-task' : 'removeTask'
    'dblclick #task-name' : 'editTask'
    'keypress #edit-task' : 'editOnEnter'
    'click #task-complete': 'toggleComplete'
    'blur #edit-task'     : 'render'
    'mousedown #task-name': 'cut'
    'mouseup #task-name'  : 'release'
 
  initialize: ->
    @model.bind 'remove', @remove, @

  model = null

  cut: ->
    model = @model

  release: ->
    

  render: ->
    $(@el).html(@template(task: @model))
    @

  editTask: ->
    $(@el).html(@template({flag: true}))
    @

  removeTask: ->
    @model.destroy()

  toggleComplete: ->
    @model.set({complete: !@model.get 'complete'}).save()
    $(@el).html(@template(task: @model))

  editOnEnter: (event) ->
    return if event.keyCode != 13
    @model.set({name: @$('#edit-task').val()}).save()
    $(@el).html(@template(task: @model))
