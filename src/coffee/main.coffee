###
  Digital Comic main.coffee
  author: Elijah Kliot <@ekliot>
###

###
  init vars
###

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

###
  local/private methods
###

build_from_JSON = ( data ) ->

  # check if data has an id
  if not data.id?
    console.log "received data: #{data}"

  else if data.id is 'campfire'
    console.log 'building campfire...'

    console.log data

    App.campfire.scene  = null
    App.campfire.id     = "#Campfire"
    App.campfire.layers = data.layers
    App.campfire.panels = data.panels

  else if data.id of App.chars
    console.log "building #{data.id}..."

    App.chars[data.id].layers = data.layers
    App.chars[data.id].panels = data.panels

  else
    console.log "invalid data.id: #{data.id}"
    console.log "received data: #{data}"

###
  App methods
###

# # method to transition from campfire to vignette
# App.enter_vignette = to_vignette = ( char ) ->
#   console.log "entering #{char}'s vignette"

# method to transition from vignette to campfire
App.enter_campfire = to_campfire = () ->
  console.log "entering campfire"

  console.log App.campfire

  scene = $( App.campfire.id )

  App.campfire.scene = new Parallax scene

  console.log App.campfire.scene

  # insert each layer into position
  for layer in App.campfire.layers
    console.log "building campfire layer: #{layer.id}"
    console.log layer

###
  onload
###

window.onload = () ->
  # # parse vignette datas
  # for char in App.chars
  #   console.log "building #{char}..."
  #   $.getJSON "assets/json/#{char}.json", build_from_JSON

  # init campfire data
  console.log 'window is loaded, populating campfire...'
  $.getJSON 'assets/json/campfire.json', build_from_JSON

  App.enter_campfire()
