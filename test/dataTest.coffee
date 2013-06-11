chai = require('chai')
chai.should()  
sinon = require('sinon')

assert = require("assert")

{Data} = require("../src/data")
{MockHashController} = require("./mockHashController")

describe('Data Loader', ->
	describe('Save', ->
		it('Should change the window location hash', ->
			originalHashData = "Hasn't been saved"
			mockHashController = new MockHashController()
			mockHashController.setHash(originalHashData)
			data = new Data(mockHashController)
			data.save()
			mockHashController.getHash().should.not.equal("#" + originalHashData)
		)
		it('Should not save gibberish data after loading it', ->
			gibberishHashData = "someGibb234dsf"
			mockHashController = new MockHashController()
			mockHashController.setHash(gibberishHashData)
			data = new Data(mockHashController)
			data.load()
			data.save()
			mockHashController.getHash().should.not.equal("#" + gibberishHashData)
		)
		it('Should save valid data back again even if the hash has changed', ->
			validHashData = "0000000000000000000000000"
			mockHashController = new MockHashController()
			mockHashController.setHash(validHashData)
			data = new Data(mockHashController)
			data.load()
			mockHashController.setHash("someGibberish")
			data.save()
			mockHashController.getHash().should.equal("#" + validHashData)
		)
	)
	describe('setPixel', ->
		it('Should cause save to be called', ->
			mockHashController = new MockHashController()
			data = new Data(mockHashController)
			mockSave = sinon.spy()
			data.save = mockSave

			data.setPixel(0, 0, 1)

			mockSave.called.should.be.true
		)
		it('Should cause the hash to change', ->
			mockHashController = new MockHashController()
			data = new Data(mockHashController)
			data.save()
			previousHash = mockHashController.getHash()
			data.setPixel(0, 0, 12)
			mockHashController.getHash().should.not.equal("#" + previousHash)
		)
	)
	describe('getPixelColor', ->
		it('Should return a number from saved hash', ->
			specificHashData = "0000F00000000000000000000"
			mockHashController = new MockHashController()
			mockHashController.setHash(specificHashData)
			data = new Data(mockHashController)
			data.load()
			data.getPixelColor(4, 0).should.equal(15)
		)
	)
)