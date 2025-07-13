

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading...")
            .scaleEffect(1.2)
    }
}

#Preview {
    LoadingView()
}
