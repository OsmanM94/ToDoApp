//
//  MockData.swift
//  ToDoApp
//
//  Created by Asia on 10/07/2025.
//

import Foundation

extension ToDoItem {
    static let mockItems: [ToDoItem] = [
        ToDoItem(title: "Buy groceries", isCompleted: false),
        ToDoItem(title: "Walk the dog", isCompleted: true),
        ToDoItem(title: "Finish project report", isCompleted: false),
        ToDoItem(title: "Call mom", isCompleted: true),
        ToDoItem(title: "Book dentist appointment", isCompleted: false),
        ToDoItem(title: "Clean the house", isCompleted: false),
        ToDoItem(title: "Pay bills", isCompleted: true),
        ToDoItem(title: "Read a book", isCompleted: false)
    ]
    
    static let sampleCompleted = ToDoItem(title: "Completed task", isCompleted: true)
    static let sampleIncomplete = ToDoItem(title: "Incomplete task", isCompleted: false)
    static let sampleLongTitle = ToDoItem(title: "This is a very long task title that might wrap to multiple lines", isCompleted: false)
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
