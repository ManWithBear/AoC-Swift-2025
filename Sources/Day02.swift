import Algorithms

struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    var ranges: [ClosedRange<Int>] {
        data
            .replacing("\n", with: "")
            .split(separator: ",")
            .map {
                let split = $0.split(separator: "-")
                let from = Int(split[0])!
                let to = Int(split[1])!
                return from...to
            }
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any { // 19574776074
        func isInvalid(_ id: Int) -> Bool {
            let text = String(id)
            guard text.count.isMultiple(of: 2) else { return false }
            let middle = text.index(text.startIndex, offsetBy: text.count / 2)
            return text[..<middle] == text[middle...]
        }
        return ranges
            .flatMap { $0.filter(isInvalid(_:)) }
            .reduce(0, +)
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any { // 25912654282
        func isInvalid(_ id: Int) -> Bool {
            let text = String(id)
            rep: for repeats in stride(from: 2, through: text.count, by: 1) {
                guard text.count.isMultiple(of: repeats) else { continue }
                let length = text.count / repeats
                var from = text.startIndex
                var to = text.index(from, offsetBy: length)
                let theFirstSubstring = text[..<to]
                while to < text.endIndex {
                    from = to
                    to = text.index(from, offsetBy: length)
                    if text[from..<to] != theFirstSubstring {
                        continue rep
                    }
                }
                return true
            }
            return false
        }
        return ranges
            .flatMap { $0.filter(isInvalid(_:)) }
            .reduce(0, +)
    }
}
