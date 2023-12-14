contract PrivateRamp is Ramp {
    struct Wallet {
        uint256 id;                         // ID of wallet
        address at;                         // Address of the wallet
        uint256 denomination;               // Denomination of wallet (ie $50, $100...) for privacy
    }

    struct PrivateIntent {
        address onRamper;                   // On-ramper (forwarder)'s address
        Wallet wallet;                      // Wallet to insert note into
        uint256 deposit;                    // Deposit to draw from
        uint256 intentTimestamp;            // Timestamp of when the intent was signaled
    }
}