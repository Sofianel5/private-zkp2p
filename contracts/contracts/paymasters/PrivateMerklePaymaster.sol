// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { MerkleTreeWithHistory } from "./MerkleTreeWithHistory.sol";
import { IVerifier } from "./interfaces/IVerifier.sol";
import { ReentrancyGuard } from "@openzeppelin/contracts/security/ReentrancyGuard.sol";

abstract contract PrivateMerklePaymaster is MerkleTreeWithHistory, ReentrancyGuard {

    IVerifier public immutable verifier2;

    struct Proof {
        bytes proof;
        bytes32 root;
        bytes32[] inputNullifiers;
        bytes32[2] outputCommitments;
        uint256 publicAmount;
        bytes32 extDataHash;
    }

    /**
        @dev The constructor
        @param _verifier2 the address of SNARK verifier for 2 inputs
        @param _levels hight of the commitments merkle tree
        @param _hasher hasher address for the merkle tree
        @param _token token address for the pool
    */
    constructor(
        IVerifier _verifier2,
        uint32 _levels,
        address _hasher,
        address token
    )
        MerkleTreeWithHistory(_levels, _hasher)
    {
        verifier2 = _verifier2;
        token = _token;
    }

    function verifyProof(Proof memory _args) public view returns (bool) {
        if (_args.inputNullifiers.length == 2) {
            return verifier2.verifyProof(
                _args.proof,
                [
                    uint256(_args.root),
                    _args.publicAmount,
                    uint256(_args.extDataHash),
                    uint256(_args.inputNullifiers[0]),
                    uint256(_args.inputNullifiers[1]),
                    uint256(_args.outputCommitments[0]),
                    uint256(_args.outputCommitments[1])
                ]
            );
        } else {
            revert("unsupported input count");
        }
    }

    function createDeposit(commitment1, commitment2) internal {

    }

    function withdrawDeposit() public {}
}