class DrawingCanvasClickHandler
	constructor: (@canvas, @drawer, @colorPicker, @data) ->
		@canvas.click((event) =>
			segmentWidth = @canvas.width() / 5
			segmentHeight = @canvas.height() / 5
			x = Math.floor((event.pageX - @canvas.offset().left) / segmentWidth)
			y = Math.floor((event.pageY - @canvas.offset().top) / segmentHeight)
			@drawer.drawPixel(x,y, @colorPicker.getCurrentColor())
			@data.setPixel(x,y, @colorPicker.getCurrentColor())
		)

root = exports ? window  
root.DrawingCanvasClickHandler = DrawingCanvasClickHandler