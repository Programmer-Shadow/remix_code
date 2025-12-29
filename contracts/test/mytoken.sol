// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
pragma solidity ^0.8.3;
contract MyERC20 is ERC20 {
    constructor() ERC20("OpenSpace BootCamp", "CAMP1") {
        _mint(msg.sender, 2 * 10 ** 18);
    }
}
