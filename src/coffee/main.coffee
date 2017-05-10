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
  if App.campfire.scene
    App.campfire.scene.disable()

  win_h = window.innerHeight
  win_w = window.innerWidth
  letterbox = 0.7

  body = $( "body" ).get 0
  campfire = $( App.campfire.scene_id )

  # set body's letterbox
  body.style.height  = "#{ win_h * letterbox }px"

  # set campfire dimensions
  campfire.width  "100%"
  # TODO do height better
  campfire.height "100%"

  img_width = 0

  for layer in App.campfire.layers
    if layer.image isnt '~'
      layer_div = $( "##{layer.id}" )
      layer_img = $( "##{layer.id} > img" )

      # set w/h
      layer_img.height campfire.height() # * layer.scale
      layer_img.width  "auto"

      img_width = layer_img.width()

      # # set top and left
      # coords =
      #   top: ( campfire.height() * layer.y ) - ( layer_img.height() / 2 )
      #   left: ( campfire.width() * layer.x ) - (  layer_img.width() / 2 )
      # layer_img.offset coords

      # set opacity
      layer_img.css( { 'opacity': layer.opacity } )

  top_pad = win_h * ( 1 - letterbox ) / 2
  side_pad = ( win_w - img_width ) / 2

  body.style.padding = "#{ top_pad }px #{ side_pad }px"

  if App.campfire.scene
    App.campfire.scene.enable()

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
  # turn off vignette parallax

  # init vars
  campfire_layers = $( App.campfire.layers_id )
  layers_to_add = []

  # insert each layer into position
  for layer in App.campfire.layers
    if layer.image isnt '~'
      layers_to_add.push App.build_parallax_layer layer

  campfire_layers.append layers_to_add

  # resize elements
  App.resize()

  # turn on campfire parallax
  App.campfire.scene = new Parallax $( App.campfire.scene_id ).get 0

build_from_JSON = ( data ) ->
  # check if data has an id
  if not data.id?
    console.log "received data without id: #{data}"

  else if data.id is 'campfire'
    App.campfire.scene  = null
    App.campfire.layers = data.layers
    App.campfire.panels = data.panels

    App.enter_campfire()

  else if data.id of App.chars
    App.chars[data.id].layers = data.layers
    App.chars[data.id].panels = data.panels

    # App.enter_vignette

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
  #   $.getJSON "assets/json/#{char}.json", build_from_JSON

  # init campfire data
  $.getJSON 'assets/json/campfire.json', build_from_JSON
