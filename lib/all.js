(function() {
  var CanvasDrawer, root;

  CanvasDrawer = (function() {
    function CanvasDrawer(canvas, colors) {
      this.canvas = canvas;
      this.colors = colors;
    }

    CanvasDrawer.prototype.drawPixel = function(x, y, color) {
      var context, heightToDraw, widthToDraw;

      widthToDraw = this.canvas.width() / 5;
      heightToDraw = this.canvas.height() / 5;
      context = this.canvas[0].getContext("2d");
      context.fillStyle = this.colors[color];
      return context.fillRect(x * widthToDraw, y * heightToDraw, widthToDraw, heightToDraw);
    };

    return CanvasDrawer;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.CanvasDrawer = CanvasDrawer;

}).call(this);

(function() {
  var ColorPicker, root;

  ColorPicker = (function() {
    function ColorPicker(canvas, colors) {
      var context, heightToDraw, i, widthToDraw, x, y, _i,
        _this = this;

      this.canvas = canvas;
      widthToDraw = this.canvas.width() / 4;
      heightToDraw = this.canvas.height() / 4;
      context = this.canvas[0].getContext("2d");
      for (i = _i = 0; _i < 16; i = ++_i) {
        x = widthToDraw * (i % 4);
        y = heightToDraw * (Math.floor(i / 4));
        context.fillStyle = colors[i];
        context.fillRect(x, y, widthToDraw, heightToDraw);
      }
      this.currentColor = 0;
      this.canvas.click(function(event) {
        var segmentHeight, segmentWidth;

        segmentWidth = _this.canvas.width() / 4;
        segmentHeight = _this.canvas.height() / 4;
        x = Math.floor((event.pageX - _this.canvas.offset().left) / segmentWidth);
        y = Math.floor((event.pageY - _this.canvas.offset().top) / segmentHeight);
        return _this.currentColor = y * 4 + x;
      });
    }

    ColorPicker.prototype.getCurrentColor = function() {
      return this.currentColor;
    };

    return ColorPicker;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.ColorPicker = ColorPicker;

}).call(this);

(function() {
  var Data, root,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  Data = (function() {
    var defaultHash, validCharacters;

    validCharacters = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"];

    defaultHash = "0000000000000000000010101";

    function Data(hashController) {
      this.hashController = hashController;
      this.hash = defaultHash;
    }

    Data.prototype.save = function() {
      return this.hashController.setHash(this.hash);
    };

    Data.prototype.load = function() {
      var hashStrippedHash, potentialHash;

      potentialHash = this.hashController.getHash();
      hashStrippedHash = potentialHash.substr(1);
      if (this.isValid(hashStrippedHash)) {
        return this.hash = hashStrippedHash;
      } else {
        return this.hash = defaultHash;
      }
    };

    Data.prototype.setPixel = function(x, y, value) {
      var hashIndex;

      hashIndex = this.getHashIndex(x, y);
      this.hash = this.hash.substr(0, hashIndex) + validCharacters[value] + this.hash.substr(hashIndex + 1);
      return this.save();
    };

    Data.prototype.getPixelColor = function(x, y) {
      var hashIndex, hashValue;

      hashIndex = this.getHashIndex(x, y);
      hashValue = this.hash.charAt(hashIndex);
      return validCharacters.indexOf(hashValue);
    };

    Data.prototype.isValid = function(potentialHash) {
      var char, _i, _len, _ref, _ref1;

      if (potentialHash.length !== 25) {
        return false;
      }
      _ref = potentialHash.split('');
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        char = _ref[_i];
        if (_ref1 = !char, __indexOf.call(validCharacters, _ref1) >= 0) {
          return false;
        }
      }
      return true;
    };

    Data.prototype.getHashIndex = function(x, y) {
      return (y * 5) + x;
    };

    return Data;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.Data = Data;

}).call(this);

(function() {
  var DrawingCanvasClickHandler, root;

  DrawingCanvasClickHandler = (function() {
    function DrawingCanvasClickHandler(canvas, drawer, colorPicker, data) {
      var _this = this;

      this.canvas = canvas;
      this.drawer = drawer;
      this.colorPicker = colorPicker;
      this.data = data;
      this.canvas.click(function(event) {
        var segmentHeight, segmentWidth, x, y;

        segmentWidth = _this.canvas.width() / 5;
        segmentHeight = _this.canvas.height() / 5;
        x = Math.floor((event.pageX - _this.canvas.offset().left) / segmentWidth);
        y = Math.floor((event.pageY - _this.canvas.offset().top) / segmentHeight);
        _this.drawer.drawPixel(x, y, _this.colorPicker.getCurrentColor());
        return _this.data.setPixel(x, y, _this.colorPicker.getCurrentColor());
      });
    }

    return DrawingCanvasClickHandler;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.DrawingCanvasClickHandler = DrawingCanvasClickHandler;

}).call(this);

(function() {
  var HashController, root;

  HashController = (function() {
    function HashController() {}

    HashController.prototype.setHash = function(newHash) {
      return window.location.hash = newHash;
    };

    HashController.prototype.getHash = function() {
      return window.location.hash;
    };

    return HashController;

  })();

  root = typeof exports !== "undefined" && exports !== null ? exports : window;

  root.HashController = HashController;

}).call(this);
