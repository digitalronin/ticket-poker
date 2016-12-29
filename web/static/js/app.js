// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket   from "./socket"
import React    from "react"
import ReactDOM from "react-dom"

import CoderEstimates from "./components/coder_estimates"

export var App = {
  run: function(){

    if (window.ticketId) {

      let reactTarget = document.getElementById("estimates-react-target")

      socket.connect()
      let channel = socket.channel(`ticket:${window.ticketId}`)
      channel.join()
        .receive("ok",    resp => { /* console.log("Joined successfully", resp) */ })
        .receive("error", resp => { console.log("Unable to join", resp)      })

      // window.ticketId is set by a script tag in the ticket/show template
      ReactDOM.render(<CoderEstimates channel={channel} ticketId={window.ticketId} />, reactTarget)
    }

    let clipboard = new Clipboard(".js-clipboard-trigger")
    clipboard.on('success', function(e) {
      // TODO: animate the clipboard icon
      // console.info('Action:', e.action);
      // console.info('Text:', e.text);
      // console.info('Trigger:', e.trigger);
      //
      // e.clearSelection();
    });

  }
}
