Annotator.Plugin.StoreLogger = (element) ->
  { pluginInit: ->
    @annotator.subscribe('annotationCreated', (annotation) ->
      console.info 'The annotation: %O has just been created!', annotation
      return
    ).subscribe('annotationUpdated', (annotation) ->
      console.info 'The annotation: %O has just been updated!', annotation
      return
    ).subscribe 'annotationDeleted', (annotation) ->
      console.info 'The annotation: %O has just been deleted!', annotation
      return
    return
 }
