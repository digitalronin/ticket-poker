import React from "react"

import CoderEstimateHidden    from "./coder_estimate_hidden"
import CoderEstimateCompleted from "./coder_estimate_completed"
import CoderEstimatePending   from "./coder_estimate_pending"

let CoderEstimates = React.createClass({
  propTypes: {
    ticketId:  React.PropTypes.string
  },

  getInitialState() {
    return {
      url:           "",
      pointOptions:  [],
      estimates:     {}
    }
  },

  componentDidMount: function() {
    let url = `/api/tickets/${this.props.ticketId}`

    $.ajax({
      url: url,
      dataType: 'json',
      success: (response) => {
        var data = response.data
        console.log('ajax response', response.data);
        this.setState({
          url:           data.url,
          pointOptions:  data.point_options,
          estimates:     data.estimates
        })
      }
    })
  },

  render() {
    let estimateComplete = this.isEstimateComplete(this.state.estimates)

    let estimateRows = Object.keys(this.state.estimates).sort().map((key) => {
      return this.estimateRow(estimateComplete, key, this.state.estimates[key])
    })

    // TODO: remove the hr
    return(
      <div className="estimates">
        {estimateRows}
        <hr />
      </div>
    )
  },

  updateEstimate(coder, points) {
    var clone = this.cloneEstimates()
    clone[coder] = points
    // TODO: push to server
    this.setState({ estimates: clone })
  },

  cloneEstimates() {
    var clone = {}
    Object.keys(this.state.estimates).map((key) => {
      clone[key] = this.state.estimates[key]
    })
    return clone
  },


  isEstimateComplete(estimates) {
    return Object.values(estimates).indexOf(0) === -1
  },

  estimateRow(estimateComplete, coder, points) {
    var rtn

    if (points === 0) {

      rtn = <CoderEstimatePending key={coder}
                                  coder={coder}
                                  pointOptions={this.state.pointOptions}
                                  onEstimate={this.updateEstimate}
            />

    } else {
      rtn = (estimateComplete)
            ? <CoderEstimateCompleted key={coder}
                                      coder={coder}
                                      points={points}
                                      onClick={this.updateEstimate}
              />

            : <CoderEstimateHidden key={coder}
                                   coder={coder}
                                   onClick={this.updateEstimate}
              />
    }

    return rtn
  }
})

module.exports = CoderEstimates

