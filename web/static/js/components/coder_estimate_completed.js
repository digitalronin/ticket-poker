import React from "react"

var CoderEstimateCompleted = React.createClass({
  propTypes: {
    coder:    React.PropTypes.string,
    points:   React.PropTypes.number,
    onClick:  React.PropTypes.func
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
    this.props.onClick(this.props.coder, 0)
  }
})

module.exports = CoderEstimateCompleted

