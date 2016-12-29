import React from "react"

var CoderEstimateCompleted = React.createClass({
  render() {
    return(
      <div className="estimate">
        <div className="estimate-card estimate-completed" onClick={this.handleClick}>
          <span className="coder">Christian</span>: 2
        </div>
      </div>
    )
  },

  handleClick() {
    console.log('CoderEstimateCompleted change my estimate')
  }

})

module.exports = CoderEstimateCompleted

