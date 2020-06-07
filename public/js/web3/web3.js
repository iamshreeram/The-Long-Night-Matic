let account
window.addEventListener('load', async () => {
	// Modern dapp browsers...
	if (window.ethereum) {
		window.web3 = new Web3(ethereum)
		try {
			// Request account access if needed
			await ethereum.enable()
			// Acccounts now exposed
			web3.eth.sendTransaction({
				/* ... */
			})
		} catch (error) {
			// User denied account access...
		}
	}
	// Legacy dapp browsers...
	else if (window.web3) {
		window.web3 = new Web3(web3.currentProvider)
		// Acccounts always exposed
		web3.eth.sendTransaction({
			/* ... */
		})
	}
	// Non-dapp browsers...
	else {
		console.log(
			'Non-Ethereum browser detected. You should consider trying MetaMask!'
		)
	}

	// SPKJSON = require('../../../../build/SpecKart.json')

	web3.version.getNetwork((err, netId) => {
		switch (netId) {
			case '1':
				console.log('This is mainnet')
				break
			case '2':
				console.log('This is the deprecated Morden test network.')
				break
			case '3':
				console.log('This is the ropsten test network.')
				break
			case '4':
				console.log('This is the Rinkeby test network.')
				break
			case '42':
				console.log('This is the Kovan test network.')
				break
			default:
				console.log('This is an unknown network.')
		}
	})
	account = web3.eth.accounts[0]
	console.log('Log: account', account)
	const accountInterval = setInterval(function () {
		if (web3.eth.accounts[0] !== account) {
			account = web3.eth.accounts[0]
			location.reload(true)
		}
	}, 100)
})