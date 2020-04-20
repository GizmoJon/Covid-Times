import SwiftUI

struct SplashScreen: View {
  @State var animate = false
  
  var body: some View {
    ZStack {
      Color(UIColor.systemBackground)
        .edgesIgnoringSafeArea(.all)
      Text("🦠")
        .font(Font.system(size: 100))
        .rotationEffect(.degrees(animate ? 0 : 360))
        .animation(foreverAnimation)
        .onAppear {
          self.animate.toggle()
      }
    }
  }
}

var foreverAnimation: Animation {
  Animation.linear(duration: 7)
    .repeatForever()
}

struct SplashScreen_Previews: PreviewProvider {
  static var previews: some View {
    SplashScreen()
  }
}
