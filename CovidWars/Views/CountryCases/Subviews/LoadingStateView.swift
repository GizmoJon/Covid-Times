import Foundation
import SwiftUI

struct LoadingStateView: View {
  @State var isAnimating: Bool = false
  var body: some View {
    ActivityIndicator(isAnimating: $isAnimating, style: .large)
      .onAppear {
        self.isAnimating.toggle()
    }
  }
}
