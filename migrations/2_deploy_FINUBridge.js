const FINUBridge = artifacts.require("FINUBridge");
const secretTestnet = require("../secret.testnet.json");

module.exports = function (deployer, network) {
    if(network == "rinkeby") {
        deployer.deploy(FINUBridge, secretTestnet.tokenContractAddress);
    } else {
        deployer.deploy(FINUBridge, secret.tokenContractAddress);
    }
};