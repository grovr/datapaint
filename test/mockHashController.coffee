class MockHashController
	constructor: ->
		@hash = ""

	setHash: (newHash) ->
		@hash = "#" + newHash

	getHash: ->
		return @hash

root = exports ? window  
root.MockHashController = MockHashController