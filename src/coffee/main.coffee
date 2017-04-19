# ======== #
# BEEPBOOP #
# ======== #

# jQuery closure
(($) -> ) jQuery

# init "App"
window.App = {}

# method to get JSON data
# App.getJSON = getJSON = ( file, callback ) ->
#   req = new XMLHttpRequest()
#
#   req.addEventListener 'readystatechange', ->
#     if req.readyState is 4 # ReadyState Complete
#       successResultCodes = [200, 304]
#
#       if req.status in successResultCodes
#         callback req.responseText
#
#       else
#         console.log 'Error loading data...'
#
#   req.open 'GET', "src/json/#{file}.json", true
#   req.send()

App.parseJSON = parseJSON = ( data ) ->
  console.log data

# fill in the campfire scene on loading the window
window.onload = () ->
  console.log 'window is loaded, populating campfire...'
  App.campfire = {}
  App.campfire.scene = $( '#Campfire' )
  # App.campfire.data  = App.getJSON 'campfire', App.parseJSON
  $.getJSON 'campfire', App.parseJSON

# method to transition from campfire to vignette
App.to_vignette = to_vignete = ( vignette ) ->
  console.log "going to vignette " + vignette

# method to transition from vignette to campfire
App.to_campfire = to_campfire = () ->
  console.log "returning to campfire"
