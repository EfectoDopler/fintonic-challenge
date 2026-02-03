//
//  File.swift
//  test
//
//  Created by JJ on 3/2/26.
//

import Foundation

class CreateOrderViewModel: ObservableObject {
    @Published var showResult = false
    
    private var processor: Processor
    var target: Target

    init() {
        showResult = false
        processor = Processor()
        target = .init(x: 0,
                       y: 0)
    }

    func buttonClicked(rawOrder: String) {
        processor.buttonClicked(rawOrder: rawOrder)
        target = processor.getTarget()
    }

    func validateTarget() {
        if processor.isValidTarget() {
            target = processor.getTarget()
            showResult = true
        }
    }
}
