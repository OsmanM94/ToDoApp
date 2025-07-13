

import SwiftUI

struct TextInputView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var text: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Enter title", text: $text)
                    .padding()
                    .background(Color(.systemGray5), in: RoundedRectangle(cornerRadius: 12))
                    .padding()
                    .onSubmit {
                        if !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            action()
                            dismiss()
                        }
                    }
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
                            action()
                            dismiss()
                        }
                    }
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

