// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "hardhat/console.sol";

import {Oracle} from "./impl/Oracle.sol";
import {Reserve} from "./impl/Reserve.sol";
import {MinterRedeemer} from "./impl/MinterRedeemer.sol";
import {Storage} from "./impl/Storage.sol";
import {vAMM} from "./impl/vAMM.sol";
import {Getter} from "./impl/Getter.sol";

/// @title A perpetual contract w/ aTokens as collateral
/// @author Markus Schick
/// @notice You can only buy one type of perpetual and only use USDC as reserve

contract Perpetual is Reserve, Oracle, MinterRedeemer {
    using SafeERC20 for IERC20;

    /************************* constructor *************************/

    constructor(
        uint256 _quoteAssetReserve,
        uint256 _baseAssetReserve,
        address _euroOracleAddress,
        address[] memory _reserveTokens,
        address[] memory _reserveOracles
    )
        Oracle(_reserveTokens, _reserveOracles, _euroOracleAddress)
        MinterRedeemer(_quoteAssetReserve, _baseAssetReserve)
    {}
}
