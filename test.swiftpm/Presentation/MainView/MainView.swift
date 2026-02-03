import SwiftUI

struct MainView: View {
    @ObservedObject private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer().frame(width: 10)
                    TextField("Orders",
                              text: $viewModel.requestText)
                    .padding(30)
                    .border(.gray)
                    Spacer()
                    .frame(width: 10)
                }
                Spacer().frame(height: 20)
                HStack(spacing: 20) {
                    Button("Send order") {
                        viewModel.buttonClicked()
                    }
                    .padding(10)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .sheet(isPresented: $viewModel.showModal) {
                        if viewModel.validateTarget() {
                            VStack(spacing: 20) {
                                Text("X: \(viewModel.target.x)")
                                Text("Y: \(viewModel.target.y)")
                            }
                        }
                    }
                    NavigationLink(destination: CreateOrderViewAssembler.assemble()) {
                        Text("Create order")
                            .padding(10)
                            .background(.green)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
    }
}
