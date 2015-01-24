#
#Question Tree Annotator Plugin
#Copyright (C) 2014 Zachary Zibrat / Deciding Force
#License TODO:
#
#Logic inspired by source code from Rich Text Annotator Plugin v1.0 (https://github.com/danielcebrian/richText-annotator)
#
_ref = undefined
__bind_ = (fn, me) ->
  ->
    fn.apply me, arguments

__hasProp_ = {}.hasOwnProperty
__extends_ = (child, parent) ->
  ctor = ->
    @constructor = child
    return
  for key of parent
    child[key] = parent[key]  if __hasProp_.call(parent, key)
  ctor:: = parent::
  child:: = new ctor()
  child.__super__ = parent::
  child

Annotator.Plugin.QuestionTree = ((_super) ->
  QuestionTree = (element, options) ->
    _ref = QuestionTree.__super__.constructor.apply(this, arguments)
    _ref
  __extends_ QuestionTree, _super
  QuestionTree::pluginInit = ->
    me = this
    annotator = @annotator
    editor = @annotator.editor
    topics = @options.tuaData.topics
    destinationURL = @options.destination
    $widget = $(".annotator-widget")
    states = []

    #Check that annotator is working
    return  unless Annotator.supported()

    #Viewer setup
    # annotator.viewer.addField({
    #   load: this.updateViewer,
    # });

    # removes default annotation view
    # $(editor.element).find('textarea').remove();
    annotator.subscribe "annotationEditorShown", (editor, annotation) ->
      console.log topics[0].questions
      $("#annotator-field-0").remove()

      # $('.annotator-controls').hide();
      $(".text-thresher-completion-form").remove()  if $(".text-thresher-completion-form").length
      topicsHTML = me.topicsList(topics)
      $widget.append topicsHTML
      annotator.editor.checkOrientation()

      # create a state object which will track the answers given
      states.push annotation:
        text: annotation.quote
        startOffset: annotation.ranges[0].startOffset
        endOffset: annotation.ranges[0].endOffset

      return

    annotator.subscribe "annotationEditorHidden", ->


    # $('.annotator-listing').children().show();
    $widget.on "click", ".thresher-answer", (e) ->

      # either the view state is topic list
      unless _.last(states).topicId
        topicClass = $(e.target).attr("class").split(" ")
        $.get("http://text-thresher.herokuapp.com/tasks").success (data) ->
          JSON.parse(data).topics.forEach (topic) ->
            if slugify(topic.name) is topicClass[1]
              _.extend _.last(states),
                topicName: topicClass[1]
                topicId: $(e.target).attr("id")
                questions: topic.questions
                top: true
                answers: []

            return

          $(".state-element").remove()
          updatedHTML = me.populateEditor(states, topics)
          $widget.append updatedHTML
          return


      # or question/answer view
      else
        answeredQuestionId = $(".text-thresher-form").find(".question-container").last().attr("id")
        answerId = $("input:radio:checked:last").val()
        _.last(states).answers.push
          question: answeredQuestionId
          answer: answerId

        _.last(states).top = false
        _.last(states).questions.forEach (question) ->
          if question.id is answeredQuestionId
            if question.dependencies.length

              # if there are questions but no dependencies, we are done
              if not _.some(question.dependencies,
                if: answerId
              ) and not _.some(question.dependencies,
                if: answeredQuestionId
              )
                _.last(states)["done"] = true
              else
                dependency = _.filter(question.dependencies,
                  if: answerId
                )[0] or question.dependencies[0]
                _.last(states)["activeQuestion"] = dependency["then"]
            else
              _.last(states)["done"] = true

            # we're done with this question, and remove its dependencies
            # this defines the 'complete' state : all question dependencies are empty arrays
            # question.dependencies = [];
            _.extend question,
              dependencies: []

          return

        $(".state-element").remove()
        updatedHTML = me.populateEditor(states, topics)
        $widget.append updatedHTML

      # console.log("All states: ")
      console.log states
      console.log "Current state:"
      console.log _.last(states)
      return

    $widget.on "click", ".thresher-submit", (e) ->
      e.preventDefault()
      return

    $(".annotator-cancel").click ->
      $(".text-thresher-form").last().remove()
      return

    $(".annotator-save").click ->
      console.log "aslkdja"
      $(".state-element").remove()
      payload = _.last(states)
      if _.last(states).done
        $("th#" + payload.topicName).css "color", "green"
        column = $("th#" + payload.topicName).index() + 1
        $("table tr.topic td:nth-child(" + column + ")").css "color", "green"
        console.log "You are finished with topic " + payload.topicName + "!!"
      $.ajax
        url: destinationURL
        method: "POST"
        data: payload

      return

    return

  QuestionTree::completionForm = (states) ->
    editorHTML = "<form role=\"form\" class=\"text-thresher-completion-form\">"
    editorHTML += "You are finished. <button class=\"btn btn-primary submit thresher-submit\">Submit Answers</button>"
    editorHTML += "</form>"
    editorHTML

  QuestionTree::sendData = (states, url) ->
    console.log "making an AJAX request to the url!"
    return

  QuestionTree::topicsList = (topics) ->
    editorHTML = "<div class=\"text-thresher-form\"><ul class=\"list-unstyled state-element\">"
    editorHTML += "<label>Please choose a topic: </label>"
    topics.forEach (topic) ->
      editorHTML += "<li><button type=\"button\" class=\"thresher-answer " + slugify(topic.name)
      editorHTML += " btn btn-primary\" + id=" + topic.id + ">" + topic.name + "</button></li>"
      return

    editorHTML += "</div>"
    editorHTML

  QuestionTree::populateEditor = (states, topics) ->
    editorHTML = ""
    that = this
    if _.last(states).done
      console.log "done"
      editorHTML += that.completionForm(states)
    else

      # var questions = _.last(states).questions;
      questions = _.find(topics,
        id: _.last(states).topicId
      ).questions
      editorHTML += "<form role=\"form\" class=\"text-thresher-form\"><ul class=\"list-unstyled state-element\">"

      # check if top-level question state
      if _.last(states).top
        _.filter(questions, "top").forEach (question) ->
          editorHTML += that.populateQuestionHTML(question)
          return

        editorHTML += "<button type=\"button\" class=\"thresher-answer btn btn-success\">Next</button>"
      else if _.last(states)
        questionId = _.last(states).activeQuestion
        question = _.filter(questions,
          id: questionId
        )[0]
        editorHTML += that.populateQuestionHTML(question)
        editorHTML += "<li><button type=\"button\" class=\"thresher-answer btn btn-success\">Submit</button></li>"
      editorHTML += "</ul></form>"
    editorHTML

  QuestionTree::populateQuestionHTML = (question) ->
    htmlString = "<div class=\"form-group question-container\" id=" + question.id + "><label>" + question.text + "</label>"
    switch question.type
      when "multiplechoice"
        question.answers.forEach (answer) ->
          htmlString += "<div class=\"radio\"><label><input type=\"radio\" class=\"thresher-question\" name=\"optionsRadios\" value="
          htmlString += answer.id + ">" + answer.text + "</label></div>"
          return

    htmlString += "</div>"
    htmlString

  QuestionTree::updateEditor = (field, annotation) ->


  # editor.fields[1].element.innerHTML = that.populateEditor(states, topics);
  # $(field).innerHTML = this.populateEditor(states, topics);
  # var text = typeof annotation.text!='undefined'?annotation.text:'';
  # console.log($(field))

  # $(field).remove(); //this is the auto create field by annotator and it is not necessary
  QuestionTree::updateViewer = (field, annotation) ->
    textDiv = $(field.parentNode).find("div:first-of-type")[0]
    textDiv.innerHTML = annotation.text

    # $(textDiv).addClass('richText-annotation');
    $(field).remove() #this is the auto create field by annotator and it is not necessary
    return

  QuestionTree
)(Annotator.Plugin)
