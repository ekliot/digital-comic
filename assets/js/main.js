// Generated by CoffeeScript 1.12.5

/*
  Digital Comic main.coffee
  author: Elijah Kliot <@ekliot>
 */


/*
  init vars
 */

(function() {
  var build_from_JSON, build_parallax_layer, enter_campfire, enter_vignette, init_app, resize;

  (function($) {})(jQuery);


  /*
    local/private methods
   */

  resize = function() {
    var body, campfire, i, img_width, layer, layer_div, layer_img, len, letterbox, ref, side_pad, top_pad, win_h, win_w;
    if (App.campfire.scene) {
      App.campfire.scene.disable();
    }
    win_h = window.innerHeight;
    win_w = window.innerWidth;
    letterbox = 0.7;
    body = $("body").get(0);
    campfire = $(App.campfire.scene_id);
    body.style.height = (win_h * letterbox) + "px";
    campfire.width("100%");
    campfire.height("100%");
    img_width = 0;
    ref = App.campfire.layers;
    for (i = 0, len = ref.length; i < len; i++) {
      layer = ref[i];
      if (layer.image !== '~') {
        layer_div = $("#" + layer.id);
        layer_img = $("#" + layer.id + " > img");
        layer_img.height(campfire.height());
        layer_img.width("auto");
        img_width = layer_img.width();
        layer_img.css({
          'opacity': layer.opacity
        });
      }
    }
    top_pad = win_h * (1 - letterbox) / 2;
    side_pad = (win_w - img_width) / 2;
    body.style.padding = top_pad + "px " + side_pad + "px";
    if (App.campfire.scene) {
      return App.campfire.scene.enable();
    }
  };

  build_parallax_layer = function(layer) {
    return layer = "<div id=\"" + layer.id + "\" class=\"layer\" data-depth=\"" + layer.depth + "\">\n    <img src=\"" + layer.image + "\" style=\"position: absolute;\">\n</div>\n";
  };

  enter_vignette = function(char) {
    return console.log("entering " + char + "'s vignette");
  };

  enter_campfire = function() {
    var campfire_layers, i, layer, layers_to_add, len, ref;
    campfire_layers = $(App.campfire.layers_id);
    layers_to_add = [];
    ref = App.campfire.layers;
    for (i = 0, len = ref.length; i < len; i++) {
      layer = ref[i];
      if (layer.image !== '~') {
        layers_to_add.push(App.build_parallax_layer(layer));
      }
    }
    campfire_layers.append(layers_to_add);
    App.resize();
    return App.campfire.scene = new Parallax($(App.campfire.scene_id).get(0));
  };

  build_from_JSON = function(data) {
    if (data.id == null) {
      return console.log("received data without id: " + data);
    } else if (data.id === 'campfire') {
      App.campfire.scene = null;
      App.campfire.layers = data.layers;
      App.campfire.panels = data.panels;
      return App.enter_campfire();
    } else if (data.id in App.chars) {
      App.chars[data.id].layers = data.layers;
      return App.chars[data.id].panels = data.panels;
    } else {
      console.log("invalid data.id: " + data.id);
      return console.log("received data: " + data);
    }
  };

  init_app = function() {
    window.App = {};
    App.campfire = {
      scene_id: '#Campfire',
      layers_id: '#CampfireLayers',
      scene: null,
      layers: {},
      panels: {}
    };
    App.vignette = {
      id: '#Vignette',
      scene: null,
      layers: {},
      panels: {}
    };
    App.chars = {
      markos: {},
      genesia: {},
      khund: {},
      djindo: {},
      hatun: {}
    };
    App.build_from_JSON = build_from_JSON;
    App.resize = resize;
    App.build_parallax_layer = build_parallax_layer;
    App.enter_campfire = enter_campfire;
    return App.enter_vignette = enter_vignette;
  };


  /*
    onload
   */

  window.onload = function() {
    init_app();
    window.onresize = function() {
      return App.resize();
    };
    return $.getJSON('assets/json/campfire.json', build_from_JSON);
  };

}).call(this);
