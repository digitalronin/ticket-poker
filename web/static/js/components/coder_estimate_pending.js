import React from "react"

import EstimateChoice from "./estimate_choice"

// TODO: pass in coder and point options

let CoderEstimatePending = React.createClass({
  propTypes: {
    coder:         React.PropTypes.string,
    pointOptions:  React.PropTypes.array,
    onEstimate:    React.PropTypes.func
  },

  render() {
    let choices = this.props.pointOptions.map((p) => {
      return <EstimateChoice coder={this.props.coder}
                             key={p}
                             value={p}
                             onClick={this.props.onEstimate}
        />
    })

    return(
      <div className="estimate">
        <div className="estimate-card estimate-pending">
          <div className="coder">{this.props.coder}</div>
        </div>
        {choices}
      </div>
    )
  }
})

module.exports = CoderEstimatePending

