

import Foundation

struct ToDoItem: Identifiable, Equatable, Hashable {
    var id = UUID()
    var textInput: String
    var isCompleted: Bool = false
}
