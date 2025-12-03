import Algorithms

struct Day03: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    var entities: [[Int]] {
        data.split(separator: "\n").map {
            $0.compactMap { Int(String($0)) }
        }
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any { // 17324
        func maxValue(in bank: [Int]) -> Int {
            let max1 = bank.max()!
            let index1 = bank.firstIndex(of: max1)!
            let newStart = bank.index(after: index1)
            if newStart == bank.endIndex {
                let max2 = bank[..<index1].max()!
                return max2 * 10 + max1
            }
            let max2 = bank[newStart...].max()!
            return max1 * 10 + max2
        }

        return entities
            .map(maxValue(in:))
            .reduce(0, +)
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any { // 171846613143331
        func pow10(_ p: Int) -> Int {
            Array(repeating: 10, count: p).reduce(1, *)
        }

        func maxValue(in bank: [Int], of length: Int) -> Int {
            if length == 0 {
                return 0
            }
            let max = bank.max()!
            if length == 1 {
                return max
            }
            let index = bank.firstIndex(of: max)!
            let rightLength = min(length - 1, bank.count - index - 1)
            let rightValue = maxValue(in: Array(bank[index.advanced(by: 1)...]), of: rightLength)
            let value = max * pow10(rightLength) + rightValue

            let leftLength = length - 1 - rightLength
            if leftLength == 0 {
                return value
            }
            let leftValue = maxValue(in: Array(bank[..<index]), of: leftLength)
            return leftValue * pow10(rightLength + 1) + value
        }

        return entities
            .map { maxValue(in: $0, of: 12) }
            .reduce(0, +)
    }
}
