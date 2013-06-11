class CanvasDrawer
	constructor: (@canvas, @colors) -> 

	drawPixel: (x, y, color) ->
		widthToDraw = @canvas.width() / 5
		heightToDraw = @canvas.height() / 5
		context = @canvas[0].getContext("2d")
		context.fillStyle = @colors[color]
		context.fillRect(x * widthToDraw, y * heightToDraw, widthToDraw, heightToDraw)

root = exports ? window  
root.CanvasDrawer = CanvasDrawer