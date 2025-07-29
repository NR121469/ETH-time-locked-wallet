// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title ETH Time Locked Wallet
 * @dev A smart contract that allows users to deposit ETH and lock it for a specified time period
 * @author Your Name
 */
contract Project {
    // Struct to store lock details
    struct TimeLock {
        uint256 amount;
        uint256 unlockTime;
        bool withdrawn;
    }
    
    // Mapping from user address to their time locks
    mapping(address => TimeLock[]) public userLocks;
    
    // Events
    event FundsLocked(address indexed user, uint256 amount, uint256 unlockTime, uint256 lockIndex);
    event FundsWithdrawn(address indexed user, uint256 amount, uint256 lockIndex);
    event EmergencyWithdrawal(address indexed user, uint256 amount, uint256 penalty);
    
    // Constants
    uint256 public constant EMERGENCY_PENALTY_PERCENT = 10; // 10% penalty for emergency withdrawal
    
    /**
     * @dev Lock ETH for a specified duration
     * @param _lockDuration Duration in seconds to lock the funds
     */
    function lockFunds(uint256 _lockDuration) external payable {
        require(msg.value > 0, "Must send ETH to lock");
        require(_lockDuration > 0, "Lock duration must be greater than 0");
        require(_lockDuration <= 365 days, "Lock duration cannot exceed 1 year");
        
        uint256 unlockTime = block.timestamp + _lockDuration;
        
        // Create new time lock
        TimeLock memory newLock = TimeLock({
            amount: msg.value,
            unlockTime: unlockTime,
            withdrawn: false
        });
        
        userLocks[msg.sender].push(newLock);
        uint256 lockIndex = userLocks[msg.sender].length - 1;
        
        emit FundsLocked(msg.sender, msg.value, unlockTime, lockIndex);
    }
    
    /**
     * @dev Withdraw funds after the lock period has expired
     * @param _lockIndex Index of the lock to withdraw from
     */
    function withdrawFunds(uint256 _lockIndex) external {
        require(_lockIndex < userLocks[msg.sender].length, "Invalid lock index");
        
        TimeLock storage userLock = userLocks[msg.sender][_lockIndex];
        
        require(!userLock.withdrawn, "Funds already withdrawn");
        require(block.timestamp >= userLock.unlockTime, "Funds are still locked");
        require(userLock.amount > 0, "No funds to withdraw");
        
        uint256 amount = userLock.amount;
        userLock.withdrawn = true;
        
        // Transfer funds to user
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
        
        emit FundsWithdrawn(msg.sender, amount, _lockIndex);
    }
    
    /**
     * @dev Emergency withdrawal with penalty (10% fee)
     * @param _lockIndex Index of the lock to withdraw from
     */
    function emergencyWithdraw(uint256 _lockIndex) external {
        require(_lockIndex < userLocks[msg.sender].length, "Invalid lock index");
        
        TimeLock storage userLock = userLocks[msg.sender][_lockIndex];
        
        require(!userLock.withdrawn, "Funds already withdrawn");
        require(userLock.amount > 0, "No funds to withdraw");
        require(block.timestamp < userLock.unlockTime, "Lock period already expired, use regular withdrawal");
        
        uint256 penalty = (userLock.amount * EMERGENCY_PENALTY_PERCENT) / 100;
        uint256 withdrawAmount = userLock.amount - penalty;
        
        userLock.withdrawn = true;
        
        // Transfer funds minus penalty to user
        (bool success, ) = payable(msg.sender).call{value: withdrawAmount}("");
        require(success, "Transfer failed");
        
        emit EmergencyWithdrawal(msg.sender, withdrawAmount, penalty);
    }
    
    // View functions
    
    /**
     * @dev Get the number of locks for a user
     * @param _user Address of the user
     * @return Number of locks
     */
    function getUserLockCount(address _user) external view returns (uint256) {
        return userLocks[_user].length;
    }
    
    /**
     * @dev Get lock details for a specific user and lock index
     * @param _user Address of the user
     * @param _lockIndex Index of the lock
     * @return amount The locked amount
     * @return unlockTime The unlock timestamp
     * @return withdrawn Whether funds have been withdrawn
     * @return timeRemaining Time remaining until unlock (0 if already unlocked)
     */
    function getLockDetails(address _user, uint256 _lockIndex) 
        external 
        view 
        returns (
            uint256 amount,
            uint256 unlockTime,
            bool withdrawn,
            uint256 timeRemaining
        ) 
    {
        require(_lockIndex < userLocks[_user].length, "Invalid lock index");
        
        TimeLock storage userLock = userLocks[_user][_lockIndex];
        
        amount = userLock.amount;
        unlockTime = userLock.unlockTime;
        withdrawn = userLock.withdrawn;
        
        if (block.timestamp >= unlockTime) {
            timeRemaining = 0;
        } else {
            timeRemaining = unlockTime - block.timestamp;
        }
    }
    
    /**
     * @dev Get total locked amount for a user (excluding withdrawn funds)
     * @param _user Address of the user
     * @return Total locked amount
     */
    function getTotalLockedAmount(address _user) external view returns (uint256) {
        uint256 totalLocked = 0;
        
        for (uint256 i = 0; i < userLocks[_user].length; i++) {
            if (!userLocks[_user][i].withdrawn) {
                totalLocked += userLocks[_user][i].amount;
            }
        }
        
        return totalLocked;
    }
    
    /**
     * @dev Get contract balance
     * @return Contract's ETH balance
     */
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
