import React from "react"

import CoderEstimateHidden    from "./coder_estimate_hidden"
import CoderEstimateCompleted from "./coder_estimate_completed"
import CoderEstimatePending   from "./coder_estimate_pending"

let CoderEstimates = React.createClass({
  propTypes: {
    channel:   React.PropTypes.object,
    ticketId:  React.PropTypes.string
  },

  getInitialState() {
    return {
      url:           "",
      pointOptions:  [],
      estimates:     {}
    }
  },

  componentDidMount() {
    this.fetchServerData()
    this.props.channel.on("update", this.fetchServerData)
  },

  render() {
    let estimateComplete = this.isEstimateComplete(this.state.estimates)

    let estimateRows = Object.keys(this.state.estimates).sort().map((key) => {
      return this.estimateRow(estimateComplete, key, this.state.estimates[key])
    })

    return(
      <div className="estimates">
        {estimateRows}
      </div>
    )
  },

  isEstimateComplete(estimates) {
    let values = Object.keys(estimates).map((key) => { return estimates[key] })
    return values.indexOf(0) === -1
  },

  estimateRow(estimateComplete, coder, points) {
    var rtn

    if (points === 0) {
      rtn = <CoderEstimatePending key={coder}
                                  coder={coder}
                                  pointOptions={this.state.pointOptions}
                                  onEstimate={this.updateEstimate} />
    } else {
      rtn = (estimateComplete)
            ? <CoderEstimateCompleted key={coder}
                                      coder={coder}
                                      points={points}
                                      onClick={this.updateEstimate} />
            : <CoderEstimateHidden key={coder}
                                   coder={coder}
                                   onClick={this.updateEstimate} />
    }

    return rtn
  },


  updateEstimate(coder, points) {
    var estimates = this.cloneEstimates(this.state.estimates)
    estimates[coder] = points

    var data = {
      ticket: {
        estimates: estimates
      }
    }

    this.pushDataToServer(data)
  },

  convertJsonData(data) {
    return {
      url: data.url,
      pointOptions: data.point_options.map((i) => { return parseInt(i) }),
      estimates: this.cloneEstimates(data.estimates)
    }
  },

  cloneEstimates(estimates) {
    var clone = {}
    Object.keys(estimates).map((key) => {
      clone[key] = parseInt(estimates[key])
    })
    return clone
  },

  dataUrl() {
    return `/api/tickets/${this.props.ticketId}`
  },

  fetchServerData() {
    $.ajax({
      url: this.dataUrl(),
      dataType: 'json',
      success: (response) => {
        this.setState(this.convertJsonData(response.data))
      }
    })
  },

  pushDataToServer(data) {
    $.ajax({
      url: this.dataUrl(),
      dataType: 'json',
      method: 'PUT',
      data: data,
      success: (response) => {
        this.props.channel.push('update', {})
        // this.setState(this.convertJsonData(response.data))
      }
    })
  }

})

module.exports = CoderEstimates
