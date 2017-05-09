###
  Digital Comic main.coffee
  author: Elijah Kliot <@ekliot>
###

###
  init vars
###

# jQuery closure
(($) -> ) jQuery

###
  local/private methods
###

build_parallax_layer = ( depth ) ->
  layer = """
          <div class="layer" data-depth="#{depth}">
              <img src="#{img}">
          </div>
          """

# method to transition from campfire to vignette
enter_vignette = ( char ) ->
  console.log "entering #{char}'s vignette"

# method to transition from vignette to campfire
enter_campfire = ->
  console.log "entering campfire"

  console.log App.campfire

  # insert each layer into position
  for layer in App.campfire.layers
    console.log "building campfire layer: #{layer.id}"
    console.log layer

  App.campfire.scene = new Parallax $( App.campfire.id ).get 0

init_app = ->
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

  App.enter_campfire = enter_campfire
  App.enter_vignette = enter_vignette

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

    App.enter_campfire()

  else if data.id of App.chars
    console.log "building #{data.id}..."

    App.chars[data.id].layers = data.layers
    App.chars[data.id].panels = data.panels

  else
    console.log "invalid data.id: #{data.id}"
    console.log "received data: #{data}"

###
  onload
###

window.onload = ->
  init_app()

  # # parse vignette datas
  # for char in App.chars
  #   console.log "building #{char}..."
  #   $.getJSON "assets/json/#{char}.json", build_from_JSON

  # init campfire data
  console.log 'window is loaded, populating campfire...'
  $.getJSON 'assets/json/campfire.json', build_from_JSON
