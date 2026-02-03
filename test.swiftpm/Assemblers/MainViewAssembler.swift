//
//  File.swift
//  test
//
//  Created by JJ on 3/2/26.
//

import Foundation

enum MainViewAssembler {
    @MainActor static func assemble() -> MainView {
        let viewModel = MainViewModel()
        return .init(viewModel: viewModel)
    }
}
