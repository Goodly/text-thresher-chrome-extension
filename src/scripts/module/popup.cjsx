React = require 'react/addons'

Login = require 'cjsx!./login'
CreateTUA = require 'cjsx!./create-tua'
EditTUA = require 'cjsx!./edit-tua'
TUAItem = require 'cjsx!./tua-item'
TUAItemTextInput = require 'cjsx!./tua-item-text-input'
Buttons = require 'cjsx!./buttons'

Popup = React.createClass

  render: ->
    <div>
      <Login/>
      <EditTUA/>
    </div>

module.exports = Popup
