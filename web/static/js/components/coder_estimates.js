import React from "react"

import CoderEstimateHidden from "./coder_estimate_hidden"
import CoderEstimateCompleted from "./coder_estimate_completed"
import CoderEstimatePending from "./coder_estimate_pending"

// TODO: pass in the state as estimates hash and pointOptions array
// TODO: get the ticket data from the server
// TODO: push new ticket data to the server

var CoderEstimates = React.createClass({
  propTypes: {
    estimates: React.PropTypes.object,
    pointOptions: React.PropTypes.array
  },

  getInitialState() {
    return {
      estimates: this.props.estimates
    }
  },

  render() {
    var estimateComplete = this.isEstimateComplete(this.state.estimates)

    var estimateRows = Object.keys(this.state.estimates).map((key) => {
      return this.estimateRow(estimateComplete, key, this.state.estimates[key])
    })

    return(
      <div className="estimates">
        {estimateRows}
        <hr />
      </div>
    )
  },


  isEstimateComplete(estimates) {
    return Object.values(estimates).indexOf(0) === -1
  },


  estimateRow(estimateComplete, coder, points) {
    var rtn

    if (points === 0) {
      rtn = <CoderEstimatePending key={coder} coder={coder} pointOptions={this.props.pointOptions} />
    } else {
      rtn = (estimateComplete)
            ? <CoderEstimateCompleted key={coder} coder={coder} points={points} />
            : <CoderEstimateHidden key={coder} coder={coder} />
    }

    return rtn
  }
})

module.exports = CoderEstimates

