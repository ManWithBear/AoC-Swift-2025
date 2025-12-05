import Algorithms

struct Day04: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var entities: [[Character]]

    init(data: String) {
        self.entities = data
            .split(separator: "\n")
            .compactMap { $0.filter( { _ in true }) }
    }

    var height: Int { entities.count }
    var width: Int { entities[0].count }

    func neighbours(at x: Int, _ y: Int, in entities: [[Character]] ) -> Int {
        var n = 0

        if x > 0,         y > 0,          entities[y - 1][x - 1].isPaperRoll { n += 1 }
        if                y > 0,          entities[y - 1][x].isPaperRoll     { n += 1 }
        if x + 1 < width, y > 0,          entities[y - 1][x + 1].isPaperRoll { n += 1 }

        if x > 0,                         entities[y][x - 1].isPaperRoll     { n += 1 }
        if x + 1 < width,                 entities[y][x + 1].isPaperRoll     { n += 1 }

        if x > 0,         y + 1 < height, entities[y + 1][x - 1].isPaperRoll { n += 1 }
        if                y + 1 < height, entities[y + 1][x].isPaperRoll     { n += 1 }
        if x + 1 < width, y + 1 < height, entities[y + 1][x + 1].isPaperRoll { n += 1 }

        return n
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any { // 1428
        var count = 0
        for i in 0..<height {
            for j in 0..<width {
                if entities[i][j].isPaperRoll, neighbours(at: j, i, in: entities) < 4 {
                    count += 1
                }
            }
        }
        return count
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        var entities = self.entities
        var count = 0
        var toRemove: [(x: Int, y: Int)] = []
        repeat {
            count += toRemove.count
            for (j, i) in toRemove {
                entities[i][j] = "."
            }
            toRemove = []
            for i in 0..<height {
                for j in 0..<width {
                    if entities[i][j].isPaperRoll, neighbours(at: j, i, in: entities) < 4 {
                        toRemove.append((j, i))
                    }
                }
            }
        } while !toRemove.isEmpty
        return count
    }
}
private extension Character {
    var isPaperRoll: Bool { self == "@" }
}
