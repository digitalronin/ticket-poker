import React from "react"

import CoderEstimateHidden from "./coder_estimate_hidden"
import CoderEstimateCompleted from "./coder_estimate_completed"
import CoderEstimatePending from "./coder_estimate_pending"

// TODO: pass in the state as estimates hash and pointOptions array
// TODO: work out whether or not the estimate is complete
// TODO: get the ticket data from the server
// TODO: push new ticket data to the server

var CoderEstimates = React.createClass({
  propTypes: {
    estimateComplete: React.PropTypes.bool,
    estimates: React.PropTypes.object,
    pointOptions: React.PropTypes.array
  },

  render() {
    console.log('CoderEstimates', this.props.estimates, this.props.pointOptions);

    var alice   = this.estimateRow(false, "Alice", 3)
    var bob     = this.estimateRow(true, "Bob", 7)
    var charlie = this.estimateRow(false, "Charlie", 0)

    return(
      <div className="estimates">
        {alice}
        {bob}
        {charlie}
        <hr />
      </div>
    )
  },

  estimateRow(estimateComplete, coder, points) {
    console.log('estimateCard', estimateComplete, coder, points);
    var rtn

    if (points === 0) {
      rtn = <CoderEstimatePending coder={coder} pointOptions={this.props.pointOptions} />
    } else {
      rtn = (estimateComplete)
            ? <CoderEstimateCompleted coder={coder} points={points} />
            : <CoderEstimateHidden coder={coder} />
    }

    return rtn
  }
})

module.exports = CoderEstimates

