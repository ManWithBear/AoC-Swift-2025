import Algorithms

struct Day08: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    private var initialPoints: [Point]
    private var distances: [Distance]

    init(data: String) {
        self.data = data

        let points = data
            .split(separator: "\n")
            .map(Point.init)
        self.initialPoints = points

        var distances: [Distance] = []
        for i in 0..<points.count {
            for j in (i + 1)..<points.count {
                distances.append(Distance(p1: points[i], p2: points[j]))
            }
        }
        self.distances = distances.sorted { $0.value < $1.value }
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any { // 330786
        part1(connections: 1000)
    }
    func part1(connections: Int) -> Any {
        var sets = QuickSets(points: initialPoints)
        for d in distances[..<connections] {
            sets.join(d.p1, d.p2)
        }
        return sets
            .flatten()
            .values
            .sorted(by: >)
            .prefix(3)
            .reduce(1, *)
    }

    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any { // 3276581616
        let count = initialPoints.count
        var sets = QuickSets(points: initialPoints)
        var connected = 1
        for d in distances {
            if sets.join(d.p1, d.p2) {
                connected += 1
            }
            if connected == count {
                return d.p1.x * d.p2.x
            }
        }
        return 0
    }
}

private struct Point: Hashable {
    let x, y, z: Int

    init(_ line: Substring) {
        let parts = line.split(separator: ",")
        self.x = Int(parts[0])!
        self.y = Int(parts[1])!
        self.z = Int(parts[2])!
    }
}

private struct Distance: Hashable {
    let p1: Point
    let p2: Point
    let value: Int

    init(p1: Point, p2: Point) {
        self.p1 = p1
        self.p2 = p2
        self.value = (p1.x - p2.x) * (p1.x - p2.x)
            + (p1.y - p2.y) * (p1.y - p2.y)
            + (p1.z - p2.z) * (p1.z - p2.z)
    }
}

private struct QuickSets {
    private var idCounter: Int
    private var sets: [Point: Int]
    private var supersets: [Int: Int] = [:]

    init(points: [Point]) {
        self.idCounter = points.count
        self.sets = Dictionary(
            uniqueKeysWithValues: points
                .enumerated()
                .map { ($1, $0) }
        )
    }

    private mutating func idx(for superset: Int?) -> Int? {
        guard let superset else { return nil }
        supersets[superset] = idx(for: supersets[superset])
        return supersets[superset] ?? superset
    }

    @discardableResult
    private mutating func idx(for point: Point) -> Int {
        sets[point] = idx(for: sets[point]!)
        return sets[point]!
    }

    @discardableResult
    mutating func join(_ p1: Point, _ p2: Point) -> Bool {
        let s1 = idx(for: p1)
        let s2 = idx(for: p2)
        guard s1 != s2 else { return false }
        supersets[s1] = idCounter
        supersets[s2] = idCounter
        idCounter += 1
        return true
    }

    mutating func flatten() -> [Int: Int] {
        sets.keys.forEach {
            idx(for: $0)
        }
        return Dictionary(sets.values.map { ($0, 1) }, uniquingKeysWith: +)
    }
}
