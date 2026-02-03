//
//  OrderBuilder.swift
//  test
//
//  Created by JJ on 2/2/26.
//

import Foundation

// MARK: - Scan Data Model

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
