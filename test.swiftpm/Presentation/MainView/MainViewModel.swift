//
//  File.swift
//  test
//
//  Created by JJ on 3/2/26.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var requestText: String
    @Published var showModal: Bool
    
    private var processor: Processor
    var target: Target
    
    init() {
        requestText = ""
        showModal = false
        processor = Processor()
        target = .init(x: 0,
                       y: 0)
    }
    
    func buttonClicked() {
        processor.buttonClicked(rawOrder: requestText)
        target = processor.getTarget()
        showModal = true
    }
    
    func validateTarget() -> Bool {
        processor.isValidTarget()
    }
}
