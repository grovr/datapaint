chai = require('chai')
chai.should()  
sinon = require('sinon')

assert = require("assert")

{Data} = require("../src/Data")
{ColorPicker} = require("../src/ColorPicker")
{CanvasDrawer} = require("../src/CanvasDrawer")
{DrawingCanvasClickHandler} = require("../src/drawingCanvasClickHandler")
{MockCanvasGetter} = require("./mockCanvasGetter")
{MockHashController} = require("./mockHashController")

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

describe('Drawing Canvas Click Handler', ->
	describe('Recieving a click', ->
		it('Should call drawPixel on drawingCanvas', ->
			mockCanvasGetter = new MockCanvasGetter()
			mockCanvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			mockColorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockHashController = new MockHashController()
			mockData = new Data(mockHashController)
			mockCanvasDrawer.drawPixel = sinon.spy()
			drawingCanvasClickHandler = new DrawingCanvasClickHandler(mockCanvasGetter, mockCanvasDrawer, mockColorPicker, mockData)
			mockCanvasGetter.performMockClick(0, 0)
			mockCanvasDrawer.drawPixel.called.should.be.true
		)
		it('Should call drawPixel for the 5th pixel when that is clicked', ->
			mockCanvasGetter = new MockCanvasGetter()
			mockCanvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			mockColorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockHashController = new MockHashController()
			mockData = new Data(mockHashController)
			mockCanvasDrawer.drawPixel = sinon.spy()
			drawingCanvasClickHandler = new DrawingCanvasClickHandler(mockCanvasGetter, mockCanvasDrawer, mockColorPicker, mockData)
			clickX = mockCanvasGetter.offset().left + (mockCanvasGetter.width() / 5) * 0.5
			clickY = mockCanvasGetter.offset().top + (mockCanvasGetter.height() / 5) * 1.5
			mockCanvasGetter.performMockClick(clickX, clickY)
			mockCanvasDrawer.drawPixel.getCall(0).args[0].should.equal(0)
			mockCanvasDrawer.drawPixel.getCall(0).args[1].should.equal(1)
		)
		it('Should pass in the colorPickers currentColor', ->
			mockCanvasGetter = new MockCanvasGetter()
			mockCanvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			mockColorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockHashController = new MockHashController()
			mockData = new Data(mockHashController)
			mockCanvasDrawer.drawPixel = sinon.spy()
			drawingCanvasClickHandler = new DrawingCanvasClickHandler(mockCanvasGetter, mockCanvasDrawer, mockColorPicker, mockData)
			mockCanvasGetter.performMockClick(0, 0)
			mockCanvasDrawer.drawPixel.getCall(0).args[2].should.equal(mockColorPicker.getCurrentColor())
		)
		it('Should call setPixel on the data object', ->
			mockCanvasGetter = new MockCanvasGetter()
			mockCanvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			mockColorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockHashController = new MockHashController()
			mockData = new Data(mockHashController)
			mockData.setPixel = sinon.spy()
			drawingCanvasClickHandler = new DrawingCanvasClickHandler(mockCanvasGetter, mockCanvasDrawer, mockColorPicker, mockData)
			mockCanvasGetter.performMockClick(0, 0)
			mockData.setPixel.called.should.be.true
		)
		it('Should call setPixel on the data object for the 7th pixel when that is clicked', ->
			mockCanvasGetter = new MockCanvasGetter()
			mockCanvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			mockColorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockHashController = new MockHashController()
			mockData = new Data(mockHashController)
			mockData.setPixel = sinon.spy()
			drawingCanvasClickHandler = new DrawingCanvasClickHandler(mockCanvasGetter, mockCanvasDrawer, mockColorPicker, mockData)
			clickX = mockCanvasGetter.offset().left + (mockCanvasGetter.width() / 5) * 2.5
			clickY = mockCanvasGetter.offset().top + (mockCanvasGetter.height() / 5) * 1.5
			mockCanvasGetter.performMockClick(clickX, clickY)
			mockData.setPixel.getCall(0).args[0].should.equal(2)
			mockData.setPixel.getCall(0).args[1].should.equal(1)
		)
		it('Should pass in the colorPickers currentColor to the data object', ->
			mockCanvasGetter = new MockCanvasGetter()
			mockCanvasDrawer = new CanvasDrawer(mockCanvasGetter, colorArray)
			mockColorPicker = new ColorPicker(mockCanvasGetter, colorArray)
			mockHashController = new MockHashController()
			mockData = new Data(mockHashController)
			mockData.setPixel = sinon.spy()
			drawingCanvasClickHandler = new DrawingCanvasClickHandler(mockCanvasGetter, mockCanvasDrawer, mockColorPicker, mockData)
			mockCanvasGetter.performMockClick(0, 0)
			mockData.setPixel.getCall(0).args[2].should.equal(mockColorPicker.getCurrentColor())
		)
	)
)