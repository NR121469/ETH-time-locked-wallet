# ETH Time Locked Wallet

## Project Description

The ETH Time Locked Wallet is a smart contract built on Ethereum that allows users to deposit ETH and lock it for a predetermined time period. This creates a trustless savings mechanism where users cannot access their funds until the specified lock period expires, promoting disciplined saving habits and long-term holding strategies.

The contract provides flexibility by allowing multiple time locks per user, each with different amounts and unlock times. Users can also perform emergency withdrawals with a penalty fee if urgent access to funds is needed before the lock period expires.

## Project Vision

Our vision is to create a decentralized financial tool that promotes responsible saving and investment behaviors in the cryptocurrency space. By implementing time-locked savings mechanisms, we aim to:

- Encourage long-term thinking and reduce impulsive spending
- Provide a trustless alternative to traditional time deposits
- Create a foundation for more complex DeFi savings products
- Help users build disciplined financial habits through blockchain technology

## Key Features

### Core Functionality
- **Time-Locked Deposits**: Users can deposit ETH and lock it for a specified duration (up to 1 year)
- **Multiple Locks**: Support for multiple simultaneous time locks per user with different amounts and durations
- **Secure Withdrawals**: Funds can only be withdrawn after the lock period expires

### Advanced Features
- **Emergency Withdrawal**: Users can withdraw funds early with a 10% penalty fee
- **Lock Management**: View and track multiple locks with detailed information including time remaining
- **Transparent Operations**: All transactions are recorded on-chain with comprehensive event logging

### Security Features
- **Reentrancy Protection**: Safe fund transfers using low-level calls
- **Input Validation**: Comprehensive validation of all user inputs
- **Access Control**: Users can only access their own locked funds

## Future Scope

### Phase 1 Enhancements
- **Interest Earnings**: Implement yield generation on locked funds through DeFi protocols
- **Flexible Penalty Structure**: Variable penalty rates based on lock duration and early withdrawal timing
- **Batch Operations**: Allow users to withdraw from multiple locks in a single transaction

### Phase 2 Developments
- **ERC-20 Token Support**: Extend functionality to support various ERC-20 tokens
- **Governance Integration**: Implement voting mechanisms for locked token holders
- **Delegation Features**: Allow users to delegate their locked tokens for governance without unlocking

### Phase 3 Advanced Features
- **Integration with DeFi Protocols**: Connect with lending/borrowing platforms for enhanced yield
- **NFT Certificates**: Issue NFTs representing time-locked positions for tradeable savings certificates
- **Multi-Signature Support**: Add multi-sig functionality for institutional users
- **Cross-Chain Compatibility**: Expand to other EVM-compatible blockchains

### Long-term Vision
- **Savings Automation**: Implement recurring deposits and automatic lock renewals
- **Social Features**: Group savings challenges and community-driven saving goals
- **Insurance Integration**: Partner with DeFi insurance protocols to protect locked funds
- **Mobile DApp**: Develop user-friendly mobile application for easy access and management

---

## Contract Structure

```
ETH-Time-Locked-Wallet/
├── Project.sol          # Main smart contract
└── README.md           # Project documentation
```

## Getting Started

1. Deploy the `Project.sol` contract to Ethereum network
2. Users can call `lockFunds()` with ETH and lock duration
3. Monitor locks using view functions
4. Withdraw funds after lock period expires using `withdrawFunds()`
5. Use `emergencyWithdraw()` for early access with penalty

## License

This project is licensed under the MIT License.



Contract Address: 0x850A4Dd61B4D044359d971f579d603951D7D12EF

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/58e33d9c-8215-4488-8f87-dffaa5fe76f5" />
