sinon = require('sinon')

class MockCanvasGetter
	constructor: ->
		@mockContext = 
			fillRect: sinon.spy()
		@[0] = 
			getContext: =>
				return @mockContext

	getContext: ->
		return @mockContext

	width: ->
		100

	height: ->
		200

	offset: ->
		left: 20
		top: 30

	click: (@clickFunction) ->

	performMockClick: (x, y) ->
		@clickFunction(
			pageX: x
			pageY: y 
		)


root = exports ? window  
root.MockCanvasGetter = MockCanvasGetter