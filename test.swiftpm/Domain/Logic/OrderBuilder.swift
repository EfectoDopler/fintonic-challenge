//
//  OrderBuilder.swift
//  test
//
//  Created by JJ on 2/2/26.
//

import Foundation

// MARK: - Scan Data Model
struct ScanData: Identifiable {
    let id = UUID()
    var x: Int
    var y: Int
    var enemyType: EnemyType
    var enemyCount: Int
    var hasAllies: Bool
    var alliesCount: Int
    
    init(x: Int = 0, y: Int = 0, enemyType: EnemyType = .soldier, enemyCount: Int = 1, hasAllies: Bool = false, alliesCount: Int = 0
    ) {
        self.x = x
        self.y = y
        self.enemyType = enemyType
        self.enemyCount = enemyCount
        self.hasAllies = hasAllies
        self.alliesCount = alliesCount
    }
}

// MARK: - Order Builder
class OrderBuilder: ObservableObject {
    @Published var selectedProtocols: Set<Protocols> = []
    @Published var scans: [ScanData] = []
    
    func toggleProtocol(aProtocol: Protocols) {
        if selectedProtocols.contains(aProtocol) {
            selectedProtocols.remove(aProtocol)
        } else {
            selectedProtocols.insert(aProtocol)
        }
    }
    
    func addNewScan() {
        scans.append(ScanData())
    }
  
    func buildJSON() -> String? {
        let order = buildOrder()
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        
        guard let jsonData = try? encoder.encode(order) else {
            return nil
        }
        
        return String(data: jsonData, encoding: .utf8)
    }
    
    private func buildOrder() -> Order {
        let protocols = Array(selectedProtocols)
        
        let scanObjects = scans.map { scanData in
            Order.Scan(coordinates: Coordinates(x: scanData.x,
                                                y: scanData.y
                ),
                enemies: Enemy(type: scanData.enemyType,
                               number: scanData.enemyCount
                ),
                allies: scanData.hasAllies ? scanData.alliesCount : nil
            )
        }

        return Order(
            protocols: protocols,
            scan: scanObjects
        )
    }
}
