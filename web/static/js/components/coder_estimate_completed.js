import React from "react"

let CoderEstimateCompleted = React.createClass({
  propTypes: {
    coder:    React.PropTypes.string,
    points:   React.PropTypes.number,
    onClick:  React.PropTypes.func
  },

  render() {
    return(
      <div className="estimate">
        <div className="estimate-card estimate-completed" onClick={this.handleClick}>
          <div className="coder">{this.props.coder}</div>
          <div className="estimate-value blue-grey-text">
            {this.props.points}
          </div>
        </div>
      </div>
    )
  },

  handleClick() {
    this.props.onClick(this.props.coder, 0)
  }
})

module.exports = CoderEstimateCompleted

