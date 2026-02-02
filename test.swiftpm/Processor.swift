//
//  Processor.swift
//  test
//
//  Created by JJ on 2/2/26.
//

import Foundation


import Foundation

typealias Scan = Order.Scan

class Processor {
    private var target: Target?

    func buttonClicked(rawOrder: String) {
        let decoder = JSONDecoder()
        let data = Data(rawOrder.utf8)
        
        do {
            let order = try decoder.decode(Order.self,
                                           from: data)
    
            target = process(order: order)
        } catch  {
            print("Parse error")
            target = nil
        }
    }

    func isValidTarget() -> Bool {
        target != nil
    }

    func getTarget() -> Target {
        if let unwrappedTarget = target {
            return unwrappedTarget
        } else {
            return .init(x: 0,
                         y: 0)
        }
    }
}

private extension Processor {
    private func process(order: Order) -> Target {
        var resultTarget = Target(x: 0,
                                  y: 0)
    
        var filteredScan = filterScan(scan: order.scan,
                                      protocols: order.protocols)

        filteredScan = filteredScan.isEmpty ? order.scan : filteredScan

        order.protocols.forEach { enabledProtocol in
            switch enabledProtocol {
            case .closestEnemies:
                resultTarget = calculateDistance(isClosest: true,
                                                 originTarget: resultTarget,
                                                 scan: filteredScan)
            case .furthestEnemies:
                resultTarget = calculateDistance(isClosest: false,
                                                 originTarget: resultTarget,
                                                 scan: filteredScan)
            default:
                let firstScan = filteredScan.first!
                resultTarget = .init(x: firstScan.coordinates.x,
                                     y: firstScan.coordinates.y)
            }
        }

        return resultTarget
    }
    
    private func filterScan(scan: [Scan], protocols: [Protocols]) -> [Scan] {
        return scan.compactMap { scan in
            if protocols.contains(.assistAllies),
               scan.allies != nil {
                return scan
            } else if protocols.contains(.avoidCrossfire),
                      scan.allies == nil {
                return scan
            } else if protocols.contains(.avoidMech),
                      scan.enemies.type != .mech {
                return scan
            } else if protocols.contains(.prioritizeMech),
                      scan.enemies.type == .mech {
                return scan
            }

            return nil
        }
    }

    private func calculateDistance(isClosest: Bool, originTarget: Target, scan: [Scan]) -> Target {
        var distanceX = originTarget.x
        var distanceY = originTarget.y

        scan.forEach { iScan in
            if iScan.coordinates.x < 100 && iScan.coordinates.y < 100 {
                let initialDistance = sqrt(Double(distanceX * distanceX + distanceY * distanceY))
                let iDistance = sqrt(Double(iScan.coordinates.x * iScan.coordinates.x + iScan.coordinates.y * iScan.coordinates.y))
                
                if isClosest && (initialDistance == 0 || iDistance < initialDistance)  {
                    distanceX = iScan.coordinates.x
                    distanceY = iScan.coordinates.y
                }

                if !isClosest && (initialDistance == 0 || iDistance > initialDistance)  {
                    distanceX = iScan.coordinates.x
                    distanceY = iScan.coordinates.y
                }
            }
        }
        
        return .init(x: distanceX,
                     y: distanceY)
    }
}
