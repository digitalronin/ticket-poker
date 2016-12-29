import React from "react"

import Foo from "./foo"

var HelloWorld = React.createClass({
  render() {
    return(
      <div>
        <h1>Hello React</h1>
        <Foo />
      </div>
    )
  }
})

module.exports = HelloWorld

