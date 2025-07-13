
import SwiftUI

struct ErrorView: View {
    let error: ToDoError
    let retryAction: () async -> Void
    
    var body: some View {
        ContentUnavailableView {
            Label(error.message, systemImage: "questionmark")
        } description: {
            Text("Tap to try again.")
        } actions: {
            /// An AsyncButton would be more suitabele for this scenario to handle automatic task cancellation when view disappears via .task(id: ) { } modifier
            Button {
                Task {
                    await retryAction()
                }
            } label: {
                Text("Tap")
            }
            .buttonStyle(.bordered)
            .controlSize(.extraLarge)
        }
    }
}

//struct ErrorView: View {
//    let error: ToDoError
//    let retryAction: () async -> Void
//    
//    @State private var isRunningTask: Bool = false
//    
//    init(error: ToDoError, retryAction: @escaping () async -> Void) {
//        self.error = error
//        self.retryAction = retryAction
//    }
//    
//    var body: some View {
//        ContentUnavailableView {
//            Label(error.message, systemImage: "exclamationmark.triangle")
//        } description: {
//            Text("Tap to try again.")
//        } actions: {
//            Button {
//                isRunningTask = true
//            } label: {
//                HStack {
//                    if isRunningTask {
//                        ProgressView()
//                            .scaleEffect(0.8)
//                    } else {
//                    Text("Try Again")
//                    }
//                }
//            }
//            .task(id: isRunningTask) {
//                if isRunningTask {
//                    await retryAction()
//                    isRunningTask = false
//                }
//            }
//            .disabled(isRunningTask)
//            .buttonStyle(.bordered)
//            .controlSize(.large)
//        }
//    }
//}

