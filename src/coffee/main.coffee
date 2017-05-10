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

resize = ->
  win_h = window.innerHeight
  win_w = window.innerWidth
  letterbox = 0.7

  # set body's letterbox
  body = $( "body" ).get 0
  body.style.height  = "#{ win_h * letterbox }px"
  body.style.padding = "#{ win_h * ( 1 - letterbox ) / 2 }px 0px"

  # set campfire dimensions
  campfire = $( App.campfire.scene_id )
  campfire.width  win_w
  # TODO do height better
  campfire.height win_h * letterbox

  for layer in App.campfire.layers
    if layer.image isnt '~'
      layer_div = $( "##{layer.id}" )
      layer_img = $( "##{layer.id} > img" )

      # set w/h
      layer_img.height( campfire.height() * layer.scale )
      layer_img.width( "auto" )

      # set top and left
      coords =
        top: ( campfire.height() * layer.y ) - ( layer_img.height() / 2 )
        left: ( campfire.width() * layer.x ) - (  layer_img.width() / 2 )
      layer_img.offset coords
      console.log coords

      # set opacity
      layer_img.css( { 'opacity': layer.opacity } )

build_parallax_layer = ( layer ) ->
  layer = """
          <div id="#{ layer.id }" class="layer" data-depth="#{ layer.depth }">
              <img src="#{ layer.image }" style="position: absolute;">
          </div>

          """

# method to transition from campfire to vignette
enter_vignette = ( char ) ->
  console.log "entering #{char}'s vignette"

# method to transition from vignette to campfire
enter_campfire = ->
  console.log "entering campfire"

  campfire_layers = $( App.campfire.layers_id )
  layers_to_add = []

  # insert each layer into position
  for layer in App.campfire.layers
    if layer.image isnt '~'
      console.log "building campfire layer: #{layer.id}"
      layers_to_add.push App.build_parallax_layer layer

  campfire_layers.append layers_to_add

  App.resize()

  App.campfire.scene = new Parallax $( App.campfire.scene_id ).get 0

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

init_app = ->
  window.App = {}

  App.campfire =
    scene_id: '#Campfire'
    layers_id: '#CampfireLayers'
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

  App.build_from_JSON = build_from_JSON
  App.resize = resize
  App.build_parallax_layer = build_parallax_layer
  App.enter_campfire = enter_campfire
  App.enter_vignette = enter_vignette

###
  onload
###

window.onload = ->
  init_app()

  window.onresize = ->
    App.resize()

  # # parse vignette datas
  # for char in App.chars
  #   console.log "building #{char}..."
  #   $.getJSON "assets/json/#{char}.json", build_from_JSON

  # init campfire data
  console.log 'window is loaded, populating campfire...'
  $.getJSON 'assets/json/campfire.json', build_from_JSON
