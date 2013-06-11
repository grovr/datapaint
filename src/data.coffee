class Data
	validCharacters = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
	defaultHash = "0000000000000000000010101"

	constructor: (@hashController) -> 
		@hash = defaultHash

	save: ->
		@hashController.setHash(@hash)

	load: ->
		potentialHash = @hashController.getHash()
		hashStrippedHash = potentialHash.substr(1)
		if @isValid(hashStrippedHash)
			@hash = hashStrippedHash
		else
			@hash = defaultHash

	setPixel: (x, y, value) ->
		hashIndex = @getHashIndex(x, y)
		@hash = @hash.substr(0, hashIndex) + validCharacters[value] + @hash.substr(hashIndex + 1)
		@save()

	getPixelColor: (x, y) ->
		hashIndex = @getHashIndex(x, y)
		hashValue = @hash.charAt(hashIndex)
		return validCharacters.indexOf(hashValue)

	isValid: (potentialHash) ->
		if potentialHash.length != 25
			return false
		for char in potentialHash.split ''
			if not char in validCharacters
				return false
		return true

	getHashIndex: (x, y) ->
		return (y * 5) + x

root = exports ? window  
root.Data = Data