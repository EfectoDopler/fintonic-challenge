//
//  Protocols.swift
//  test
//
//  Created by JJ on 2/2/26.
//

import Foundation

enum Protocols: String, Codable, CaseIterable {
    case closestEnemies = "closest-enemies"
    case furthestEnemies = "furthest-enemies"
    case assistAllies = "assist-allies"
    case avoidCrossfire = "avoid-crossfire"
    case prioritizeMech = "prioritize-mech"
    case avoidMech = "avoid-mech"
    
    var displayName: String {
        switch self {
        case .closestEnemies:
            return "Closest Enemies"
        case .furthestEnemies:
            return "Furthest Enemies"
        case .assistAllies:
            return "Assist Allies"
        case .avoidCrossfire:
            return "Avoid Crossfire"
        case .prioritizeMech:
            return "Prioritize Mech"
        case .avoidMech:
            return "Avoid Mech"
        }
    }
}
