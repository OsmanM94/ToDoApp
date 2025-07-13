

import Foundation

extension ToDoItem {
    static let mockItems: [ToDoItem] = [
        ToDoItem(textInput: "Buy groceries", isCompleted: false),
        ToDoItem(textInput: "Walk the dog", isCompleted: true),
        ToDoItem(textInput: "Finish project report", isCompleted: false),
        ToDoItem(textInput: "Call mom", isCompleted: true),
        ToDoItem(textInput: "Book dentist appointment", isCompleted: false),
        ToDoItem(textInput: "Clean the house", isCompleted: false),
        ToDoItem(textInput: "Pay bills", isCompleted: true),
        ToDoItem(textInput: "Read a book", isCompleted: false)
    ]
    
    static let sampleCompleted = ToDoItem(textInput: "Completed task", isCompleted: true)
    static let sampleIncomplete = ToDoItem(textInput: "Incomplete task", isCompleted: false)
    static let sampleLongTitle = ToDoItem(textInput: "This is a very long task title that might wrap to multiple lines", isCompleted: false)
}

extension ToDoViewModel {
    static let mockEmpty: ToDoViewModel = {
        let viewModel = ToDoViewModel()
        viewModel.viewState = .empty
        return viewModel
    }()
    
    static let mockLoading: ToDoViewModel = {
        let viewModel = ToDoViewModel()
        viewModel.viewState = .loading
        return viewModel
    }()
    
    static let mockError: ToDoViewModel = {
        let viewModel = ToDoViewModel()
        viewModel.viewState = .error(.loadItemsFailed)
        return viewModel
    }()
    
    static let mockWithItems: ToDoViewModel = {
        let viewModel = ToDoViewModel()
        viewModel.items = ToDoItem.mockItems
        viewModel.viewState = .list(ToDoItem.mockItems)
        return viewModel
    }()
    
    static let mockWithFewItems: ToDoViewModel = {
        let viewModel = ToDoViewModel()
        let items = Array(ToDoItem.mockItems.prefix(3))
        viewModel.items = items
        viewModel.viewState = .list(items)
        return viewModel
    }()
}
