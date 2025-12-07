import Algorithms

struct Day07: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    var rows: [[Character]]

    init(data: String) {
        self.data = data
        self.rows = data
            .split(separator: "\n")
            .map { Array($0) }
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any { // 1600
        let firstRow = rows[0].map { $0.isStart ? "|" : $0 }
        let flowDown = rows[1...]
            .reduce((0, firstRow)) { partialResult, row in
                var (splits, previousRow) = partialResult
                var resRow = row
                for (idx, char) in previousRow.enumerated() {
                    guard char.isBeam else { continue }
                    if row[idx].isSplitter {
                        resRow[idx - 1] = "|"
                        resRow[idx + 1] = "|"
                        splits += 1
                    } else {
                        resRow[idx] = "|"
                    }
                }
                return (splits, resRow)
            }
        return flowDown.0
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any { // 8632253783011
        let firstRowIdx = rows[0].firstIndex(where: \.isStart)!
        let flowDown = rows[1...]
            .reduce([firstRowIdx: 1]) { partialResult, row in
                var timelines: [Int: Int] = [:]
                for (idx, count) in partialResult {
                    if row[idx].isSplitter {
                        timelines[idx - 1, default: 0] += count
                        timelines[idx + 1, default: 0] += count
                    } else {
                        timelines[idx, default: 0] += count
                    }
                }
                return timelines
            }
        return flowDown.values.reduce(0, +)
    }
}

private extension Character {
    var isStart: Bool { self == "S" }
    var isBeam: Bool { self == "|" }
    var isSplitter: Bool { self == "^" }
}
