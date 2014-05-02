class TodoList.Views.Footer extends Backbone.View
  el: '#footer'
  
  template: JST['tasks/footer']
  
  initialize: ->
    @collection.bind 'add', @updateRemaining, @
    @collection.bind 'change', @updateRemaining, @
    @collection.bind 'remove', @updateRemaining, @

  render: ->
    remaining = @collection.where({complete: false}).length
    $(@el).html(@template({remaining: remaining}))
    @

  updateRemaining: ->
    @$('#task-count').text(@collection.where({complete: false}).length)
