import Algorithms

struct Day06: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    nonisolated(unsafe) let fnS: [Substring: (Int, Int) -> Int] = [
        "+": (+),
        "*": (*),
    ]
    nonisolated(unsafe) let fnC: [Character: (Int, Int) -> Int] = [
        "+": (+),
        "*": (*),
    ]

    init(data: String) {
        self.data = data

    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any { // 5877594983578
        let start: [Substring: Int] = [
            "+": 0,
            "*": 1,
        ]
        var rows = data
            .split(separator: "\n")
            .map {
                $0.split(separator: " ").filter { !$0.isEmpty }
            }
        let operators = rows.removeLast()
        let numbers = rows.map { $0.map { Int($0)! } }
        var sum = 0
        for (idx, op) in operators.enumerated() {
            sum += numbers.reduce(start[op]!) {
                fnS[op]!($0, $1[idx])
            }
        }
        return sum
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any { // 11159825706149
        let start: [Character: Int] = [
            "+": 0,
            "*": 1,
        ]
        var rows = data.split(separator: "\n")
        var operators = rows
            .removeLast()
            .filter { $0 != " " }
        let rowsCount = rows.count

        var sum = 0
        var op = operators.removeLast()
        var opResult = start[op]!

        while !rows[0].isEmpty {
            var number = 0
            for i in 0..<rowsCount {
                if let digit = Int(String(rows[i].removeLast())) {
                    number *= 10
                    number += digit
                }
            }
            if number == 0 {
                // problem just ended
                sum += opResult
                op = operators.removeLast()
                opResult = start[op]!
            } else {
                // read a whole number for problem
                opResult = fnC[op]!(opResult, number)
            }
        }

        return sum + opResult
    }
}
