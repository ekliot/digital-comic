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

build_parallax_layer = ( layer ) ->
  layer = """
          <div id="#{ layer.id }" class="layer" data-depth="#{ layer.depth }">
              <img src="#{ layer.image }">
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
    if layer.image isnt '~'
      console.log "building campfire layer: #{layer.id}"
      console.log build_parallax_layer layer

  App.campfire.scene = new Parallax $( App.campfire.id ).get 0

init_app = ->
  window.App = {}

  App.campfire =
    id: '#Campfire'
    scene: null
    layers: {}
    panels: {}
  App.vignette =
    id: '#Vignette'
    scene: null
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

resize = ->
  letterbox = 0.5

  # set body's letterbox0
  body = $( "body" ).get 0
  body.style.padding = "#{window.innerWidth * (letterbox / 2)}px 0px"

  # set campfire dimensions
  campfire = $( App.campfire.id ).get 0
  campfire.style.width  = "#{window.innerWidth}px"
  # TODO do height better
  campfire.style.height = "#{window.innerWidth * letterbox}px"

  console.log "laysz"

  for layer in App.campfire.layers
    layer_div = $( layer.id )
    console.log layer_div

###
  onload
###

window.onload = ->
  init_app()
  window.onresize = resize()

  # # parse vignette datas
  # for char in App.chars
  #   console.log "building #{char}..."
  #   $.getJSON "assets/json/#{char}.json", build_from_JSON

  # init campfire data
  console.log 'window is loaded, populating campfire...'
  $.getJSON 'assets/json/campfire.json', build_from_JSON
