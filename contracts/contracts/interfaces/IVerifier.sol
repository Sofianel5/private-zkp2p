// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IVerifier {
  function verifyProof(bytes memory _proof, uint256[7] memory _input) external view returns (bool);

  function verifyProof(bytes memory _proof, uint256[21] memory _input) external view returns (bool);
}
