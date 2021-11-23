// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract FINUBridge {
    address finuTokenContractAddress;

    constructor(address _finuTokenContractAddress) {
        finuTokenContractAddress = _finuTokenContractAddress;
    }

    function setFinuTokenContractAddress(address _finuTokenContractAddress) external{
        finuTokenContractAddress = _finuTokenContractAddress;
    }

    function lockToken(uint256 amount) external {
        require(IERC20(finuTokenContractAddress).balanceOf(msg.sender) >= amount, "FINUBridge: not enough balance");
        require(IERC20(finuTokenContractAddress).allowance(msg.sender, address(this)) >= amount, "FINUBridge: not allowed");
        IERC20(finuTokenContractAddress).transferFrom(msg.sender, address(this), amount);
    }
}