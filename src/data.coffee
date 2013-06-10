class Data
	validCharacters = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "A", "B", "C", "D", "E", "F"]
	defaultHash = "0000000000000000000010101"

	constructor: (@hashController) -> 
		@hash = defaultHash

	save: ->
		@hashController.setHash(@hash)

	load: ->
		potentialHash = @hashController.getHash()
		if @isValid(potentialHash)
			@hash = potentialHash
		else
			@hash = defaultHash

	setPixel: (x, y, value) ->
		hashIndex = (y * 5) + x
		@hash = @hash.substr(0, hashIndex) + validCharacters[value] + @hash.substr(hashIndex + 1)
		@save()

	isValid: (potentialHash) ->
		if potentialHash.length != 25
			return false
		for char in potentialHash.split ''
			if not char in validCharacters
				return false
		return true




root = exports ? window  
root.Data = Data