// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract FINUBridge is Ownable {
    using SafeMath for uint256;

    address finuTokenContractAddress;
    uint256 public swapIdPointer;

    constructor(address _finuTokenContractAddress) {
        finuTokenContractAddress = _finuTokenContractAddress;
    }

    function setFinuTokenContractAddress(address _finuTokenContractAddress) external onlyOwner {
        finuTokenContractAddress = _finuTokenContractAddress;
    }

    function getCurrentSwapId() public view returns(uint){
        uint swapId = swapIdPointer;
        return swapId;
    }

    function lockToken(uint256 amount) external returns(uint){
        require(IERC20(finuTokenContractAddress).balanceOf(msg.sender) >= amount, "FINUBridge: not enough balance");
        require(IERC20(finuTokenContractAddress).allowance(msg.sender, address(this)) >= amount, "FINUBridge: not allowed");
        IERC20(finuTokenContractAddress).transferFrom(msg.sender, address(this), amount);
        swapIdPointer = swapIdPointer.add(1);
        uint swapId = swapIdPointer;
        return swapId;
    }
}