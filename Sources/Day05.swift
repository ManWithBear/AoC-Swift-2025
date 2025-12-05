import Algorithms

struct Day05: AdventDay {
    let ranges: [ClosedRange<Int>]
    let entries: [Int]

    init(data: String) {
        let parts = data.split(separator: "\n\n")
        self.ranges = parts[0]
            .split(separator: "\n")
            .map {
                let parts = $0.split(separator: "-")
                let from = Int(parts[0])!
                let to = Int(parts[1])!
                return from...to
            }
            .sorted { $0.lowerBound < $1.lowerBound }
        self.entries = parts[1]
            .split(separator: "\n")
            .map { Int($0)! }
            .sorted()
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any { // 758
        entries
            .filter { entry in ranges.contains { $0.contains(entry) } }
            .count
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any { // 343143696885053
        var count = 0
        var firstNotCountedId = 0
        for range in ranges {
            let lower = max(range.lowerBound, firstNotCountedId)
            let inRange = range.upperBound - lower + 1
            guard inRange > 0 else { continue }
            count += inRange
            firstNotCountedId = range.upperBound + 1
        }
        return count
    }
}
