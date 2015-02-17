React = require 'react/addons'
Button = require 'react-bootstrap/Button'
Glyphicon = require 'react-bootstrap/Glyphicon'


ToggleShow = React.createClass

  render: ->
    <div>
      <Button title= "Toggle" onClick={@props.onToggleShow}><Glyphicon glyph= "remove" /></Button>
    </div>

module.exports = ToggleShow
