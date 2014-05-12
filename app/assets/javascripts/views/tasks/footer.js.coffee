class TodoList.Views.Footer extends Backbone.View
  el: '#footer'
  
  template: JST['tasks/footer']
  
  initialize: ->
    @collection.bind 'destroy', @render, @

  render: ->
    remaining = @collection.where({complete: false}).length
    $(@el).html(@template({remaining: remaining, size: @collection.length}))
    @
