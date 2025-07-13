

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ToDoViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .empty:
                    EmptyStateView()
                
                case .loading:
                    LoadingView()
                
                case .error(let error):
                    ErrorView(error: error) {
                        Task {
                            await viewModel.loadItems()
                        }
                    }
                
                case .list(let items):
                    ToDoListView(items: items, viewModel: viewModel)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: viewModel.viewState)
            .navigationTitle("List")
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            ) 
            .onSubmit(of: .search) {
               /// Search
            }
            .refreshable {
               /// Refresh
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    ToDoToolbarMenu(viewModel: viewModel)
                }
            }
            .sheet(isPresented: $viewModel.showAddItemSheet) {
                AddItemSheet(viewModel: viewModel)
            }
            .sheet(isPresented: $viewModel.showEditSheet) {
                EditItemSheet(viewModel: viewModel)
            }
        }
        .task {
            /// Load items only if the list is empty to avoid unnecessary API calls
            /// when navigating back to this view or switching between tabs.
            if viewModel.items.isEmpty {
                await viewModel.loadItems()
            }
        }
    }
}

// MARK: - Toolbar
private struct ToDoToolbarMenu: View {
    let viewModel: ToDoViewModel
    
    var body: some View {
        Menu {
            Button("Add item") {
                viewModel.showAddItemSheet.toggle()
            }
            
            EditButton()
                .disabled(viewModel.items.isEmpty)
            
        } label: {
            Image(systemName: "ellipsis.circle.fill")
                .font(.title2)
        }
        .disabled(viewModel.viewState == .loading)
    }
}

// MARK: - Sheet Views
private struct AddItemSheet: View {
    let viewModel: ToDoViewModel
    
    var body: some View {
        TextInputView(
            text: Bindable(viewModel).textInput,
            title: "Add New Item",
            action: {
                Task {
                    await viewModel.addItem(title: viewModel.textInput)
                    viewModel.textInput = ""
                }
            }
        )
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(30)
    }
}

private struct EditItemSheet: View {
    let viewModel: ToDoViewModel
    
    var body: some View {
        TextInputView(
            text: Bindable(viewModel).textInput,
            title: "Edit Item",
            action: {
                if let editingItem = viewModel.editingItem {
                    let updatedItem = ToDoItem(
                        id: editingItem.id,
                        title: viewModel.textInput,
                        isCompleted: editingItem.isCompleted
                    )
                    Task {
                        await viewModel.updateItem(item: updatedItem)
                        viewModel.textInput = ""
                        viewModel.editingItem = nil
                    }
                }
            }
        )
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        .presentationCornerRadius(30)
    }
}


// MARK: - Previews
#Preview("Main App") {
    ContentView()
}

#Preview("Empty State") {
    NavigationStack {
        EmptyStateView()
            .navigationTitle("ToDo")
    }
}

#Preview("Loading State") {
    NavigationStack {
        LoadingView()
            .navigationTitle("ToDo")
    }
}

#Preview("Error State") {
    NavigationStack {
        ErrorView(error: .loadItemsFailed) {
            print("Retry tapped")
        }
        .navigationTitle("ToDo")
    }
}

#Preview("List View") {
    NavigationStack {
        ToDoListView(items: ToDoItem.mockItems, viewModel: .mockWithItems)
            .navigationTitle("ToDo")
    }
}

#Preview("Row States") {
    List {
        ToDoRowView(item: ToDoItem.sampleIncomplete, viewModel: .mockWithItems)
        ToDoRowView(item: ToDoItem.sampleCompleted, viewModel: .mockWithItems)
        ToDoRowView(item: ToDoItem.sampleLongTitle, viewModel: .mockWithItems)
    }
}

#Preview("Add Item Sheet") {
    AddItemSheet(viewModel: .mockWithItems)
}

#Preview("Text Input") {
    TextInputView(
        text: .constant(""),
        title: "Add New Item",
        action: { print("Action") }
    )
}

