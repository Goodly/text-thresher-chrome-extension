React = require 'react/addons'

HelloWorld = React.createClass

  componentDidMount: ->
    window.scroll(0,0)

  render: ->
    <div>
      <h1>Hello world!</h1>
    </div>

module.exports = HelloWorld
