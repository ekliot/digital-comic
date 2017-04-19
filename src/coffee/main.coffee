# ======== #
# BEEPBOOP #
# ======== #

# jQuery closure
(($) -> ) jQuery

# init "App"
window.App = {}

App.campfire = {}
App.vignette =
  scene:  $( '#Vignette' )
  layers: {}
  panels: {}
App.chars =
  markos:  {}
  genesia: {}
  khund:   {}
  djindo:  {}
  hatun:   {}

# method to transition from campfire to vignette
to_vignette = ( char ) ->
  console.log "going to #{char}'s vignette"

# method to transition from vignette to campfire
to_campfire = () ->
  console.log "returning to campfire"

build_from_JSON = ( data ) ->
  # check if data has an id
  if not data.id?
    console.log "data lacks id"
    console.log "received data: #{data}"
  else if data.id is 'campfire'
    console.log "building campfire..."
    App.campfire.to_vignette = to_vignette
    App.campfire.to_campfire = to_campfire

    App.campfire.scene = $( '#Campfire' )

    App.campfire.layers = data.layers
    App.campfire.panels = data.panels
  else if data.id of App.chars
    console.log "building #{data.id}..."
    App.chars[data.id].layers = data.layers
    App.chars[data.id].panels = data.panels
  else
    console.log "invalid data.id: #{data.id}"
    console.log "received data: #{data}"

window.onload = () ->
  # parse vignette datas
  for char in App.chars
    console.log "building #{char}..."
    $.getJSON "src/json/#{char}.json", App.build_from_JSON

  console.log 'window is loaded, populating campfire...'
  $.getJSON 'src/json/campfire.json', App.build_from_JSON
