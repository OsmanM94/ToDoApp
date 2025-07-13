

import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ContentUnavailableView("No items to show", systemImage: "tray.fill")
    }
}

#Preview {
    EmptyStateView()
}
