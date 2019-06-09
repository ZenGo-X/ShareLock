# ShareLock
Mixing for Cryptocurrencies from Multiparty ECDSA (https://eprint.iacr.org/2019/563)

## Privacy issues on blockchains
On blockchains all transaction data is public. If any of one's unique identifier (name, e-mail, Twitter handle) is linked to one of her on-chain addresses, then financial privacy is permanently lost. The loss of financial privacy allows an attacker to assess the wealth of an individual, company or organization. Moreover, also the consumption behaviour of an individiual or company might be revealed this way: how much they pay to suppliers, employees etc.  

## ShareLock protocol
Participants deposit to a contract, then they run off-chain a distributed key generation (DKG) protocol and threshold sign the list of the addresses derived from the threshold public keys.
Any of the participants, or say a wallet company, we call this party an activator could poke the contract with the threshold signed transaction to make the contract sending out the mixed coins to the addresses yielded from the DKG.

If parties are unable to threshold sign the “poke” transaction, then after a time-out they are able to withdraw their dirty coins (unmixed) back to their original addresses.

Since security is proven in the UC framework one could just pick her favourite threshold ECDSA protocol. In the paper we sticked to the [GG’19 paper](https://eprint.iacr.org/2019/114.pdf). However one could also use threshold BLS in order to avoid interactivity in the off-chain signing phase.

### Advantages over other constructions
Most of other constructions, [Miximus](https://github.com/barryWhiteHat/miximus) and [Vitalik's proposal](https://hackmd.io/@HWeNw8hNRimMm2m2GH56Cw/rJj9hEJTN?type=view), use zkSNARK proofs, therefore they rely on a trusted setup. All of the other constructions use tremendous amount of gas: Miximus requires cca. 2M gas for the withdrawal tx, [Möbius](https://github.com/clearmatics/mobius) needs 350,000n gas for the witdhrawal tx, where n is cardinality of the anonymity set. On the other hand ShareLock uses minimal resources of the blockchain, while not relying on a trusted setup.

## Contact us!
Feel free to [reach out](mailto:github@kzencorp.com) or join the KZen Research [Telegram]( https://t.me/kzen_research) for discussions on code and research.
