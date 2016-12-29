import React from "react"

import CoderEstimateHidden from "./coder_estimate_hidden"
import CoderEstimateCompleted from "./coder_estimate_completed"

var CoderEstimates = React.createClass({
  propTypes: {
    estimateComplete: React.PropTypes.bool
  },

  render() {
    var rtn

    if (this.props.estimateComplete) {
      rtn = <CoderEstimateCompleted />
    } else {
      rtn = <CoderEstimateHidden />
    }

    return <div className="estimates">{rtn}<hr /></div>
  }
})

module.exports = CoderEstimates

