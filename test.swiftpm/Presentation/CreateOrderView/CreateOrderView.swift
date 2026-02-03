//
//  CreateOrderView.swift
//  test
//
//  Created by JJ on 2/2/26.
//

import SwiftUI

struct CreateOrderView: View {
    @StateObject private var orderBuilder = OrderBuilder()
    @ObservedObject private var viewModel: CreateOrderViewModel
    
    init(viewModel: CreateOrderViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                    .frame(width: 10)
                Text("Protocols")
                    .padding(.top, 20)
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Protocols.allCases, id: \.self) { theProtocol in
                    Toggle(theProtocol.displayName,
                           isOn: Binding(get: { orderBuilder.selectedProtocols.contains(theProtocol) },
                                         set: { _ in orderBuilder.toggleProtocol(aProtocol: theProtocol) }
                    ))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                }
            }
            .border(.gray)
            .padding(.horizontal, 10)
            
            Spacer().frame(height: 20)
            
            HStack {
                Spacer().frame(width: 10)
                Text("Scans")
                Button(action: orderBuilder.addNewScan) {
                    Text("+")
                }
                .padding(.horizontal, 8)
                .background(.gray)
                .foregroundStyle(.white)
                Spacer()
            }
            
            VStack(spacing: 10) {
                ScrollView {
                    ForEach($orderBuilder.scans) { $scan in
                        ScanItemView(scan: $scan)
                    }
                }
            }
            .padding(.horizontal, 10)
            
            Spacer().frame(height: 20)
            
            HStack(spacing: 20) {
                Button("Execute Order") {
                    executeOrder()
                }
                .padding(10)
                .background(canExecute ? Color.green : Color.gray)
                .foregroundStyle(.white)
                .disabled(!canExecute)
                .sheet(isPresented: $viewModel.showResult) {
                    VStack(spacing: 20) {
                        Text("X: \(viewModel.target.x)")
                        Text("Y: \(viewModel.target.y)")
                    }
                }
            }
        }
    }
    
    private var canExecute: Bool {
        !orderBuilder.selectedProtocols.isEmpty && !orderBuilder.scans.isEmpty
    }
    
    private func executeOrder() {
        guard let jsonString = orderBuilder.buildJSON() else {
            return
        }
        
        viewModel.buttonClicked(rawOrder: jsonString)
        viewModel.validateTarget()
    }
}

// MARK: - Preview
#Preview {
    CreateOrderViewAssembler.assemble()
}
