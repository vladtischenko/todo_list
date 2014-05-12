class TodoList.Views.TasksIndex extends Backbone.View
  el: '#app'
  template: JST['tasks/index']
  events:
    'keypress #add-task'  : 'createOnEnter'
    'click #complete'     : 'setAllComplete'
    'click #remove-all'   : 'removeAll'
 
  initialize: ->
    @collection.fetch({reset: true})
    @collection.bind 'add', @addTask, @
    @collection.bind 'reset', @render, @
    @collection.bind 'change', @render, @
    # @collection.bind 'sort', @render, @

  dragRender: ->
    $(@el).html(@template())
    @collection.each (task) =>
      view = new TodoList.Views.TasksItem model: task
      @$('#tasks').append(view.render().el)
    @


  render: ->
    $(@el).html(@template())

    footerView = new TodoList.Views.Footer collection: @collection
    footerView.render()

    allCompleteView = new TodoList.Views.AllComplete collection: @collection
    allCompleteView.render()

    @collection.each (task) =>
      view = new TodoList.Views.TasksItem model: task
      @$('#tasks').append(view.render().el)

    @

  removeAll: ->
    model = null
    while(model = @collection.first())
      model.destroy()

  setAllComplete: ->
    if @$('#complete').prop("checked")
      @collection.each (task) =>
        task.set({complete: true}).save()
    else
      @collection.each (task) =>
        task.set({complete: false}).save() 


  createOnEnter: (event) ->
    return if event.keyCode != 13
    @collection.create({name: @$('#add-task').val(), complete: false})
    @$('#add-task').val('')

  addTask: (task) ->
    view = new TodoList.Views.TasksItem model: task
    @$('#tasks').append(view.render().el)
    @
