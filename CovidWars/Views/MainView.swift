import SwiftUI

struct MainView: View {
  @ObservedObject var syncService: DataSyncService

    var body: some View {
      if syncService.syncComplete {
        return AnyView(CountryCasesView(viewModel: viewModel))
      } else {
        return AnyView(SplashScreen()
          .onAppear {
            self.syncService.sync()
        })
      }
    }
  
  var viewModel: CountryCasesViewModel {
    CountryCasesViewModel(repository: CovidRepository())
  }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
      MainView(syncService: DataSyncService())
    }
}
