// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
//import "@aave/protocol-v2/contracts/interfaces/IAToken.sol";

import "hardhat/console.sol";

import {Oracle} from "./impl/Oracle.sol";
import {Reserve} from "./impl/Reserve.sol";
import {MinterRedeemer} from "./impl/MinterRedeemer.sol";
import {Storage} from "./impl/Storage.sol";
import {vAMM} from "./impl/vAMM.sol";
import {Getter} from "./impl/Getter.sol";
import {Margin} from "./impl/Margin.sol";

/// @title A perpetual contract w/ aTokens as collateral
/// @author Markus Schick
/// @notice You can only buy one type of perpetual and only use USDC as reserve

/// toDO:
// aUSDC (as reserve)
// scale down aTokens (see: https://docs.aave.com/developers/the-core-protocol/atokens#scaledbalanceof
// add funding rate payments (TWAP, looping, ..) (check PerpetualSwaps/Implementation/decentralized/dYdX/perpetual/contracts/protocol/v1/impl/P1Settlement.sol)
// add liquidations

// add aETH supports
// add borrow money from Aave

contract Perpetual is Reserve, Margin, MinterRedeemer, Ownable, Getter {
    using SafeERC20 for IERC20;

    /************************* constructor *************************/

    constructor(
        uint256 _quoteAssetReserve,
        uint256 _baseAssetReserve,
        address _euroOracleAddress,
        address[] memory _reserveTokens,
        address[] memory _reserveOracles
    )
        Margin(_reserveTokens, _reserveOracles, _euroOracleAddress)
        MinterRedeemer(_quoteAssetReserve, _baseAssetReserve)
    {}
}
