// Generated by CoffeeScript 1.12.5
(function() {
  var build_from_JSON, to_campfire, to_vignette;

  (function($) {})(jQuery);

  window.App = {};

  App.campfire = {};

  App.vignette = {
    scene: $('#Vignette'),
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

  to_vignette = function(char) {
    return console.log("going to " + char + "'s vignette");
  };

  to_campfire = function() {
    return console.log("returning to campfire");
  };

  build_from_JSON = function(data) {
    if (data.id == null) {
      console.log("data lacks id");
      return console.log("received data: " + data);
    } else if (data.id === 'campfire') {
      console.log("building campfire...");
      App.campfire.to_vignette = to_vignette;
      App.campfire.to_campfire = to_campfire;
      App.campfire.scene = $('#Campfire');
      App.campfire.layers = data.layers;
      return App.campfire.panels = data.panels;
    } else if (data.id in App.chars) {
      console.log("building " + data.id + "...");
      App.chars[data.id].layers = data.layers;
      return App.chars[data.id].panels = data.panels;
    } else {
      console.log("invalid data.id: " + data.id);
      return console.log("received data: " + data);
    }
  };

  window.onload = function() {
    var char, i, len, ref;
    ref = App.chars;
    for (i = 0, len = ref.length; i < len; i++) {
      char = ref[i];
      console.log("building " + char + "...");
      $.getJSON("src/json/" + char + ".json", build_from_JSON);
    }
    console.log('window is loaded, populating campfire...');
    return $.getJSON('src/json/campfire.json', build_from_JSON);
  };

}).call(this);
