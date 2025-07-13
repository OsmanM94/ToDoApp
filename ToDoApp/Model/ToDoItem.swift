

import Foundation

struct ToDoItem: Identifiable, Equatable, Hashable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
}
