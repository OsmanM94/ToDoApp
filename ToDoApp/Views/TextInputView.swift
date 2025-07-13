

import SwiftUI

struct TextInputView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var text: String
    let title: String
    let action: () async -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter title", text: $text)
                    .padding()
                    .background(Color(.systemGray5), in: RoundedRectangle(cornerRadius: 12))
                    .padding()
                    .onSubmit {
                        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Task {
                                await action()
                            }
                            dismiss()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .textContentType(.jobTitle)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel, action: { dismiss() }) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            Task {
                                await action()
                            }
                            dismiss()
                        }
                    }
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

