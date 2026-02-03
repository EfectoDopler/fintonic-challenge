//
//  ScanItemView.swift
//  test
//
//  Created by JJ on 2/2/26.
//

import SwiftUI

struct ScanItemView: View {
    @Binding var scan: ScanData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Scan Point")

            HStack(spacing: 16) {
                TextField("X",
                          text: Binding(get: { String(scan.x) },
                                        set: { scan.x = Int($0) ?? scan.x }
                ))
                .border(.gray)
                .padding(6)
                .keyboardType(.numberPad)
                
                TextField("Y",
                          text: Binding(get: { String(scan.y) },
                                        set: { scan.y = Int($0) ?? scan.y }
                ))
                .border(.gray)
                .padding(6)
                .keyboardType(.numberPad)
            }
            
            Picker("Enemy Type",
                   selection: $scan.enemyType) {
                Text("Soldier")
                    .tag(EnemyType.soldier)
                Text("Mech")
                    .tag(EnemyType.mech)
            }
            .pickerStyle(.segmented)
            
            Stepper(value: $scan.enemyCount,
                    in: 1...10) {
                Text("Enemies: \(scan.enemyCount)")
            }
            
            Toggle("Has Allies", isOn: $scan.hasAllies)
            
            if scan.hasAllies {
                Stepper(value: $scan.alliesCount,
                        in: 0...10) {
                    Text("Allies: \(scan.alliesCount)")
                }
            }
        }
        .padding()
        .border(.gray)
    }
}

// MARK: - Preview
#Preview {
    ScanItemView(scan: .constant(ScanData(x: 10,
                                          y: 20,
                                          enemyType: .soldier,
                                          enemyCount: 5,
                                          hasAllies: true,
                                          alliesCount: 2
        ))
    )
    .padding()
}
