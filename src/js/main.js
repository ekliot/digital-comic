// Generated by CoffeeScript 1.12.5
(function() {
  var getJSON, parseJSON, to_campfire, to_vignete,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  (function($) {})(jQuery);

  window.App = {};

  App.getJSON = getJSON = function(file, callback) {
    var req;
    req = new XMLHttpRequest();
    req.addEventListener('readystatechange', function() {
      var ref, successResultCodes;
      if (req.readyState === 4) {
        successResultCodes = [200, 304];
        if (ref = req.status, indexOf.call(successResultCodes, ref) >= 0) {
          return callback(req.responseText);
        } else {
          return console.log('Error loading data...');
        }
      }
    });
    req.open('GET', "src/json/" + file + ".json", false);
    return req.send();
  };

  App.parseJSON = parseJSON = function(text) {
    return console.log(text);
  };

  window.onload = function() {
    console.log('window is loaded, populating campfire...');
    App.campfire = {};
    App.campfire.scene = $('#Campfire');
    return App.getJSON('campfire', App.parseJSON);
  };

  App.to_vignette = to_vignete = function(vignette) {
    return console.log("going to vignette " + vignette);
  };

  App.to_campfire = to_campfire = function() {
    return console.log("returning to campfire");
  };

}).call(this);
