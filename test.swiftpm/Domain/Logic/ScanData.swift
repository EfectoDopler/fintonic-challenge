//
//  File.swift
//  test
//
//  Created by JJ on 3/2/26.
//

import Foundation

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
