require ('../styles/main.css')

var React = require('react');
var Main = require('cjsx!./module/main');

React.renderComponent((
  <Main/>
), document.getElementById('react-root'));
