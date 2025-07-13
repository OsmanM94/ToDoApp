

import Foundation

enum ToDoError {
    case addItemFailed
    case removeItemFailed
    case updateItemFailed
    case toggleCompletionFailed
    case loadItemsFailed
    case moveItemsFailed
    
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
        case .moveItemsFailed:
            return "Failed to move items."
        }
    }
}
