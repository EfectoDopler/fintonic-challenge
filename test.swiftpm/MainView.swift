import SwiftUI

struct MainView: View {
    @State private var requestText: String
    @State private var showModal: Bool
    @State private var showCreateOrderView: Bool = false

    private var processor: Processor
    private var target: Target
    
    init() {
        requestText = ""
        showModal = false
        target = .init(x: 0,
                       y: 0)
        processor = Processor()
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer().frame(width: 10)
                TextField("Orders",
                          text: $requestText)
                .padding(30)
                .border(.gray)
                Spacer().frame(width: 10)
            }
            Spacer().frame(height: 20)
            HStack(spacing: 20) {
                Button("Send order") {
                    processor.buttonClicked(rawOrder: requestText)
                    showModal = true
                }
                .padding(10)
                .background(.blue)
                .foregroundStyle(.white)
                .sheet(isPresented: $showModal) {
                    if processor.isValidTarget() {
                        let target = processor.getTarget()
                        VStack(spacing: 20) {
                            Text("X: \(target.x)")
                            Text("Y: \(target.y)")
                        }
                    }
                }
                Button("Create order") {
                    showCreateOrderView = true
                }
                .padding(10)
                .background(.green)
                .foregroundStyle(.white)
                .sheet(isPresented: $showCreateOrderView) {
                    CreateOrderView()
                }
            }
        }
    }
}
