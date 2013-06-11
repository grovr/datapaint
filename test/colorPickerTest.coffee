chai = require('chai')
chai.should()  
sinon = require('sinon')

assert = require("assert")

{ColorPicker} = require("../src/colorPicker")
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

describe('Color Picker', ->
	describe('constructor', ->
		it('Should draw 16 squares on startup', ->
			mockCanvasGetter = new MockCanvasGetter()
			colorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockCanvasGetter.getContext().fillRect.callCount.should.equal(16)
		)
		it('Should draw with width of 1/4 canvas width', ->
			mockCanvasGetter = new MockCanvasGetter()
			colorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockCanvasGetter.getContext().fillRect.getCall(0).args[2].should.equal(mockCanvasGetter.width() / 4)
		)
		it('Should draw with height of 1/4 canvas height', ->
			mockCanvasGetter = new MockCanvasGetter()
			colorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockCanvasGetter.getContext().fillRect.getCall(0).args[3].should.equal(mockCanvasGetter.height() / 4)
		)
		it('Should draw to 7th square at "2, 1"', ->
			mockCanvasGetter = new MockCanvasGetter()
			colorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockCanvasGetter.getContext().fillRect.getCall(6).args[0].should.equal((mockCanvasGetter.width() / 4) * 2)
			mockCanvasGetter.getContext().fillRect.getCall(6).args[1].should.equal((mockCanvasGetter.height() / 4) * 1)
		)
		it('Should draw the end with the fillStyle set to the last color', ->
			mockCanvasGetter = new MockCanvasGetter()
			colorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockCanvasGetter.getContext().fillStyle.should.equal(colorArray[15])
		)
	)
	describe('getCurrentColor', ->
		it('Should default to color 0', ->
			mockCanvasGetter = new MockCanvasGetter()
			colorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			colorPicker.getCurrentColor().should.equal(0)
		)
		it('Should after a click on 11th style return 11', ->
			mockCanvasGetter = new MockCanvasGetter()
			colorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			clickX = mockCanvasGetter.offset().left + (mockCanvasGetter.width() / 4) * 3.5
			clickY = mockCanvasGetter.offset().top + (mockCanvasGetter.height() / 4) * 2.5
			mockCanvasGetter.performMockClick(clickX, clickY)
			colorPicker.getCurrentColor().should.equal(11)
		)
	)
)