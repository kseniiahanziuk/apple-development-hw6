import Foundation

class BankAccount {
    var balance: Int = 2000
    
    func deposit(money: Int) {
        if money > 0 {
            balance += money
        } else {
            print("Deposit failure: the deposit cannot be less than or equal to zero.")
        }
    }
    
    func withdraw(money: Int) {
        if balance >= money {
            balance -= money
        } else {
            print("Withdrawal failure: the withdraw is exceeding the balance.")
        }
    }
    
    func simulateRaceCondition() {
        let dispatchGroup = DispatchGroup()
        for _ in 0..<10 {
            DispatchQueue.global().async(group: dispatchGroup) {
                self.withdraw(money: 100)
            }
        }
        
        dispatchGroup.wait()
        print("Final account balance(with race condition): \(balance)")
    }
    
    func simulateThreadSafeWithdrawals() {
        let dispatchGroup = DispatchGroup()
        let serialQueue = DispatchQueue(label: "serialQueue")
        for _ in 0..<10 {
            DispatchQueue.global().async(group: dispatchGroup) {
                serialQueue.sync {
                    self.withdraw(money: 100)
                }
            }
        }
        
        dispatchGroup.wait()
        print("Final account balance(with thread-safe withdrawals): \(balance)")
    }
}
