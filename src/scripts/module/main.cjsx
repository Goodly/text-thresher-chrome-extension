# libs
$ = require 'jQuery'
require 'Annotator'
require 'AnnotatorPlugin'
React = require 'react/addons'

# modules
Login = require 'cjsx!./login'
CreateTUA = require 'cjsx!./create-tua'
EditTUA = require 'cjsx!./edit-tua'
TUAItem = require 'cjsx!./tua-item'
TUAItemTextInput = require 'cjsx!./tua-item-text-input'
Timer = require 'jsx!./example-modules/timer'
TagsList = require 'cjsx!./tags-list'
ToggleShow = require 'cjsx!./toggle-show'

Main = React.createClass

  getInitialState: ->
    formDisplayed: true

  componentDidMount: ->
    $('html').annotator()
             .annotator('setupPlugins').annotator('addPlugin', 'StoreLogger');

    # content.annotator 'addPlugin', 'Store',
    #   prefix: '/store/endpoint'
    #   annotationData: 'uri': 'http://this/document/only'
    #   loadFromSearch:
    #     'limit': 20
    #     'uri': 'http://this/document/only'

  onToggleShow: ->
    @setState
      formDisplayed: !@.state.formDisplayed

  onLaunchLogin: (state) ->
    console.log state

  render: ->
    if @state.formDisplayed
      rightPos = '-15px'
    else
      rightPos = '-200px'
    styles =
      right: rightPos
    <div className="react-module" style={styles}>
      <div>
        <ToggleShow onToggleShow={@onToggleShow}/>
      </div>
      <div className="module-body">
        <Login onLaunchLogin={@onLaunchLogin}/>
      </div>
    </div>

module.exports = Main
