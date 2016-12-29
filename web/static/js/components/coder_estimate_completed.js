import React from "react"

var CoderEstimateCompleted = React.createClass({
  propTypes: {
    coder: React.PropTypes.string,
    points: React.PropTypes.number
  },

  render() {
    return(
      <div className="estimate">
        <div className="estimate-card estimate-completed" onClick={this.handleClick}>
          <span className="coder">{this.props.coder}</span>: {this.props.points}
        </div>
      </div>
    )
  },

  handleClick() {
    console.log(`${this.props.coder} says change my estimate`)
  }
})

module.exports = CoderEstimateCompleted

