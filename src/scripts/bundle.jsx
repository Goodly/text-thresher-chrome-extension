var React = require('react');
var App = require('./modules/App');
var Home = require('./modules/Home');
var About = require('./modules/About');
var Timer = require('./components/Timer')
var HelloWorld = require('cjsx!./modules/hello_world')
// var {DefaultRoute, Route, Routes} = require('react-router');

React.renderComponent((
  // <Routes location="history">
  //   <Route path="/" handler={App}>
  //     <DefaultRoute name="home" handler={Home} />
  //     <Route name="about" handler={About} />
  //   </Route>
  // </Routes>
  <HelloWorld/>
), document.getElementById('react-root'));
