assert = require("assert")

describe('Data Loader', ->
	describe('Save', ->
		it('Should change the window location hash', ->
			originalHashData = "Hasn't been saved"
			window = 
				location: 
					hash: originalHashData
			data = new Data()
			data.save()
			window.location.hash.should.not.equal(originalHashData)
		)
	)
)