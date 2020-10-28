const { assert } = require('chai')

const Promise = artifacts.require('./Promise.sol')

require('chai')
  .use(require('chai-as-promised'))
  .should()

contract('Promise', ([deployer, author, tipper]) => {
  let promise

  before(async () => {
    promise = await Promise.deployed()
  })

  describe('deployment', async () => {
    it('deploys successfully', async () => {
      const address = await promise.address
      assert.notEqual(address, 0x0)
      assert.notEqual(address, '')
      assert.notEqual(address, null)
      assert.notEqual(address, undefined)
    })

    it('has a name', async () => {
      const name = await promise.name()
      assert.equal(name, 'Promise')
    })
  })

  describe('agreements', async() => {
    let result, agreementCount
    const hash = 'abc123'

    before(async () => {
      result = await promise.addAgreement(hash, "Terms",  { to: author })
      agreementCount = await promise.agreementCount()
    })

    it('creates agreements', async () => {
      // SUCCESS
      assert.equal(agreementCount, 1)
      const event = result.logs[0].args
      assert.equal(event.id.toNumber(), agreementCount.toNumber, 'id is correct')
      assert.equal(event.hash, hash, 'Hash is correct')
      assert.equal(event.terms, 'Terms', 'terms are correct')
      assert.equal(event.author, author, 'contractee is correct')

      // FAILURE: Agreement must have hash
      await promise.addAgreement('', 'Terms', )
    })
  })
})