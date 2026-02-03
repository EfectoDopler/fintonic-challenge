//
//  Order.swift
//  test
//
//  Created by JJ on 2/2/26.
//

import Foundation

typealias Scan = Order.Scan
typealias Enemy = Order.Scan.Enemy
typealias EnemyType = Order.Scan.Enemy.EnemyType
typealias Coordinates = Order.Scan.Coordinates

struct Order: Codable {
    let protocols: [Protocols]
    let scan: [Scan]
    
    struct Scan: Codable {
        let coordinates: Coordinates
        let enemies: Enemy
        let allies: Int?

        struct Coordinates: Codable {
            let x: Int
            let y: Int
        }

        struct Enemy: Codable {
            let type: EnemyType
            let number: Int
            
            enum EnemyType: String, Codable {
                case soldier = "soldier"
                case mech = "mech"
            }
        }
    }
}
