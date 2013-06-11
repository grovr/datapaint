class HashController
	constructor: ->

	setHash: (newHash) ->
		window.location.hash = newHash

	getHash: ->
		return window.location.hash

root = exports ? window  
root.HashController = HashController