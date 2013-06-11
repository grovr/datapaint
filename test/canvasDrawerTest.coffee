chai = require('chai')
chai.should()  
sinon = require('sinon')

assert = require("assert")

{CanvasDrawer} = require("../src/CanvasDrawer")
{MockCanvasGetter} = require("./mockCanvasGetter")

colorArray = [
	"#000000",
	"#000001",
	"#000002",
	"#000003",
	"#000004",
	"#000005",
	"#000006",
	"#000007",
	"#000008",
	"#000009",
	"#00000A",
	"#00000B",
	"#00000C",
	"#00000D",
	"#00000E",
	"#00000F"
]

describe('Canvas Drawer', ->
	describe('drawPixel', ->
		it('Should call fillRect on the returned context', ->
			mockCanvasGetter = new MockCanvasGetter()
			canvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			canvasDrawer.drawPixel(0, 0, 0)
			mockCanvasGetter.getContext().fillRect.called.should.be.true
		)
		it('Should draw with a width 1/5 of the canvas width', ->
			mockCanvasGetter = new MockCanvasGetter()
			canvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			canvasDrawer.drawPixel(0, 0, 0)
			mockCanvasGetter.getContext().fillRect.getCall(0).args[2].should.equal(mockCanvasGetter.width() / 5)
		)
		it('Should draw with a width 1/5 of the canvas height', ->
			mockCanvasGetter = new MockCanvasGetter()
			canvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			canvasDrawer.drawPixel(0, 0, 0)
			mockCanvasGetter.getContext().fillRect.getCall(0).args[3].should.equal(mockCanvasGetter.height() / 5)
		)
		it('Should draw at the right x coord', ->
			mockCanvasGetter = new MockCanvasGetter()
			canvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			canvasDrawer.drawPixel(2, 0, 0)
			mockCanvasGetter.getContext().fillRect.getCall(0).args[0].should.equal((mockCanvasGetter.width() / 5) * 2)
		)		
		it('Should draw at the right y coord', ->
			mockCanvasGetter = new MockCanvasGetter()
			canvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			canvasDrawer.drawPixel(2, 3, 0)
			mockCanvasGetter.getContext().fillRect.getCall(0).args[1].should.equal((mockCanvasGetter.height() / 5) * 3)
		)
	)
)