import Foundation

class PrimeNumberChecker {
    
    func isPrime(_ number: Int) -> Bool {
        guard number > 1 else { return false }
        if number <= 3 { return true }
        if number % 2 == 0 || number % 3 == 0 { return false }
        var divisor = 5
        while divisor * divisor <= number {
            if number % divisor == 0 || number % (divisor + 2) == 0 { return false }
            divisor += 6
        }
        return true
    }
    
    func findPrimesConcurrently(from numbers: [Int], numberOfTasks: Int, completion: @escaping ([Int]) -> Void) {
        let dispatchGroup = DispatchGroup()
        let concurrentQueue = DispatchQueue(label: "primeCheckerQueue", attributes: .concurrent)
        let chunkSize = (numbers.count + numberOfTasks - 1) / numberOfTasks
        var results = Array(repeating: false, count: numbers.count)
        
        for taskIndex in 0..<numberOfTasks {
            dispatchGroup.enter()
            concurrentQueue.async {
                let startIndex = taskIndex * chunkSize
                let endIndex = min(startIndex + chunkSize, numbers.count)
                for index in startIndex..<endIndex {
                    results[index] = self.isPrime(numbers[index])
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .global()) {
            let primes = zip(numbers, results).filter { $0.1 }.map { $0.0 }
            completion(primes)
        }
    }
}
