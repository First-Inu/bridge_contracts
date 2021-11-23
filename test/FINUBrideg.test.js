const FINUBridge = artifacts.require("FINUBridge");
const ERC20Mock = artifacts.require("ERC20Mock");

contract("FINUBridge", (accounts) => {
    var finuBridegeContract;
    var erc20MockContract;

    before(async () => {
        erc20MockContract = await ERC20Mock.new({from: accounts[0]});
        finuBridegeContract = await FINUBridge.new(erc20MockContract.address, {from: accounts[0]});

        erc20MockContract.mint(accounts[1], 100);
    })

    describe("lockToken", () => {
        it("not working if owner have insufficient balance", async () => {
            try {
                await finuBridegeContract.lockToken(1000, {from: accounts[1]});
            } catch (error) {
                thrownError = error;
            }
            assert.include(thrownError.message, "FINUBridge: not enough balance");
        })

        it("not working if spender was not approved", async () => {
            try {
                await finuBridegeContract.lockToken(50, {from: accounts[1]});
            } catch (error) {
                thrownError = error;
            }
            assert.include(thrownError.message, "FINUBridge: not allowed");
        })

        it("works well", async () => {
            await erc20MockContract.approve(finuBridegeContract.address, 50, {from: accounts[1]});
            await finuBridegeContract.lockToken(50, {from: accounts[1]});
            assert.equal(await erc20MockContract.balanceOf(accounts[1]), 50);
        })
    })
})