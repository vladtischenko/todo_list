class TodoList.Views.TasksItem extends Backbone.View
  template: JST['tasks/item']
  events:
    'click #remove-task'  : 'removeTask'
    'dblclick #task-name' : 'editTask'
    'keypress #edit-task' : 'editOnEnter'
    'click #task-complete': 'toggleComplete'
    'blur #edit-task'     : 'render'
    'mousedown #task'     : 'cut'
    'mouseup #task'       : 'release'


  initialize: ->
    @model.bind 'destroy', @remove, @
    @model.bind 'change', @render, @

  render: ->
    $(@el).html(@template(task: @model))
    @

  model_id = null

  cut: ->
    model_id = @model.get 'id'

  release: ->
    @model.drag(model_id, @model.get 'id')
    unless model_id == @model.get 'id'
      # @model.collection.sort()
      view = new TodoList.Views.TasksIndex collection: new TodoList.Collections.Tasks
      view.dragRender()

  editTask: ->
    $(@el).html(@template({flag: true}))
    @$('#edit-task').val(@model.get 'name')
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
