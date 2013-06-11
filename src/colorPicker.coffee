class ColorPicker
	constructor: (@canvas, colors) ->
		widthToDraw = @canvas.width() / 4
		heightToDraw = @canvas.height() / 4
		context = @canvas[0].getContext("2d")
		for i in [0...16]
			x = widthToDraw * (i % 4)
			y = heightToDraw * (Math.floor(i / 4))
			context.fillStyle = colors[i]
			context.fillRect(x, y, widthToDraw, heightToDraw)
		@currentColor = 0
		@canvas.click((event) =>
			segmentWidth = @canvas.width() / 4
			segmentHeight = @canvas.height() / 4
			x = Math.floor((event.pageX - @canvas.offset().left) / segmentWidth)
			y = Math.floor((event.pageY - @canvas.offset().top) / segmentHeight)
			@currentColor = y * 4 + x
		)

	getCurrentColor: ->
		return @currentColor

root = exports ? window  
root.ColorPicker = ColorPicker