

import Foundation

enum ToDoError {
    case addItemFailed
    case removeItemFailed
    case updateItemFailed
    case toggleCompletionFailed
    case loadItemsFailed
    
    var message: String {
        switch self {
        case .addItemFailed:
            return "Failed to add item."
        case .removeItemFailed:
            return "Failed to remove item."
        case .updateItemFailed:
            return "Failed to update item."
        case .toggleCompletionFailed:
            return "Failed to toggle completion."
        case .loadItemsFailed:
            return "Failed to load items."
        }
    }
}

@Observable
final class ToDoViewModel {
    
    enum ViewState: Equatable {
        case empty
        case loading
        case error(ToDoError)
        case list([ToDoItem])
    }

    enum NetworkError: Error {
        case operationFailed
        case timeout
        case noConnection
    }
    
    var items: [ToDoItem] = []
    var textInput: String = ""
    var searchText: String = ""
    var showAddItemSheet: Bool = false
    var showEditSheet: Bool = false
    var editingItem: ToDoItem?
    var viewState: ViewState = .empty
    
    @MainActor
    func loadItems() async {
        viewState = .loading
        
        do {
            /// 1.5 seconds delay
            try await simulateNetworkOperation(delay: 1.5)
            viewState = items.isEmpty ? .empty : .list(items)
        } catch {
            viewState = .error(.loadItemsFailed)
        }
    }
    
    @MainActor
    func addItem(title: String) async {
        viewState = .loading
        
        do {
            /// 1 second delay
            try await simulateNetworkOperation(delay: 1)
            items.append(ToDoItem(textInput: title))
            viewState = .list(items)
        } catch {
            viewState = .error(.addItemFailed)
        }
    }
    
    @MainActor
    func removeItem(item: ToDoItem) async {
        viewState = .loading
        
        do {
            /// 0.8 seconds delay
            try await simulateNetworkOperation(delay: 0.8)
            items.removeAll { $0.id == item.id }
            viewState = items.isEmpty ? .empty : .list(items)
        } catch {
            viewState = .error(.removeItemFailed)
        }
    }
    
    @MainActor
    func updateItem(item: ToDoItem) async {
        viewState = .loading
        
        do {
            /// 0.8 seconds delay
            try await simulateNetworkOperation(delay: 0.8)
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                items[index] = item
                viewState = .list(items)
            }
        } catch {
            viewState = .error(.updateItemFailed)
        }
    }
    
    @MainActor
    func toggleCompletion(item: ToDoItem) async {
        viewState = .loading
        
        do {
            /// 0.5 seconds delay
            try await simulateNetworkOperation(delay: 0.5)
            if let index = items.firstIndex(where: { $0.id == item.id }) {
                items[index].isCompleted.toggle()
                viewState = .list(items)
            }
        } catch {
            viewState = .error(.toggleCompletionFailed)
        }
    }
    
    func startEditingItem(_ item: ToDoItem) {
        editingItem = item
        textInput = item.textInput
        showEditSheet = true
    }
    
    @MainActor
    func removeItems(at offsets: IndexSet) async {
        for index in offsets {
            await removeItem(item: items[index])
        }
    }
    
    // Simulates a network operation with potential failure
    private func simulateNetworkOperation(delay: Double) async throws {
        /// Network delay
        try await Task.sleep(for: .seconds(delay))
        
        /// Potential error (10% chance)
        if Int.random(in: 1...10) == 1 {
            throw NetworkError.operationFailed
        }
    }
}
