import Algorithms

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    var numbers: [Int] {
        data
            .replacing("R", with: "+")
            .replacing("L", with: "-")
            .split(separator: "\n")
            .compactMap { Int($0) }
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any { // 1129
        numbers.reduce((0, 50)) { result, rotation in
            let (zeros, pointer) = result
            let newPointer = ((pointer + rotation) % 100 + 100) % 100
            if newPointer == 0 {
                return (zeros + 1, newPointer)
            }
            return (zeros, newPointer)
        }.0
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any { // 6638
        var pointer = 50
        var counter = 0
        for rotation in numbers {
            let range = if rotation < 0 {
                stride(from: rotation, to: 0, by: 1)
            } else {
                stride(from: 1, to: rotation + 1, by: 1)
            }
            for i in range {
                pointer += i.signum()
                pointer = (pointer + 100) % 100
                if pointer == 0 {
                    counter += 1
                }
            }
        }
        return counter
    }
}
