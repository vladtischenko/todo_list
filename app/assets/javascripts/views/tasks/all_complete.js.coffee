class TodoList.Views.AllComplete extends Backbone.View
  el: '#all_complete'
  template: JST['tasks/all_complete']

  initialize: ->

  render: ->
    count = @collection.where({complete: true}).length
    if count == @collection.length
      $(@el).html(@template({all: true}))
      @
    else
      $(@el).html(@template({all: false}))
      @

