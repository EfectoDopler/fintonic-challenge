//
//  CreateOrderViewAssembler.swift
//  test
//
//  Created by JJ on 3/2/26.
//

import Foundation

enum CreateOrderViewAssembler {
    @MainActor static func assemble() -> CreateOrderView {
        let viewModel = CreateOrderViewModel()
        return .init(viewModel: viewModel)
    }
}
