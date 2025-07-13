

import SwiftUI

struct ToDoListView: View {
    let items: [ToDoItem]
    let viewModel: ToDoViewModel
    
    var body: some View {
        List {
            ForEach(items, id: \.id) { item in
                ToDoRowView(item: item, viewModel: viewModel)
            }
            .onDelete { offsets in
                Task {
                    await viewModel.removeItems(at: offsets)
                }
            }
        }
        .listRowSpacing(5)
    }
}

struct ToDoRowView: View {
    let item: ToDoItem
    let viewModel: ToDoViewModel
    
    var body: some View {
        HStack {
            CompletionButton(item: item, viewModel: viewModel)
            
            ItemTitle(item: item)
            
        }
        .swipeActions(edge: .trailing) {
            SwipeActions(item: item, viewModel: viewModel)
        }
    }
}

private struct CompletionButton: View {
    let item: ToDoItem
    let viewModel: ToDoViewModel
    
    var body: some View {
        Button(action: {
            Task {
                await viewModel.toggleCompletion(item: item)
            }
        }) {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .gray)
        }
        .buttonStyle(.plain)
    }
}

private struct ItemTitle: View {
    let item: ToDoItem
    
    var body: some View {
        Text(item.textInput)
            .strikethrough(item.isCompleted)
            .foregroundStyle(item.isCompleted ? .secondary : .primary)
    }
}

private struct SwipeActions: View {
    let item: ToDoItem
    let viewModel: ToDoViewModel
    
    var body: some View {
        Group {
            Button(role: .destructive) {
                Task {
                    await viewModel.removeItem(item: item)
                }
            } label: {
                Label("Delete", systemImage: "trash")
            }
            
            Button {
                viewModel.startEditingItem(item)
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            .tint(.blue)
        }
    }
}

