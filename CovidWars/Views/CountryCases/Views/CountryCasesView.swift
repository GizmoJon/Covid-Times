import SwiftUI

struct CountryCasesView: View {
  @ObservedObject var viewModel: CountryCasesViewModel
  
  var body: some View {
    mainView
      .onAppear{
        self.viewModel.getCountries()
    }
  }
  
  var mainView: some View {
    NavigationView<AnyView> {
      switch viewModel.state {
      case .idle:
        return AnyView(SplashScreen())
      case .loading:
        return AnyView(LoadingStateView()
          .navigationBarHidden(true))
      case .success(let viewModels):
        return AnyView(SuccessStateView(viewModels)
          .navigationBarTitle(Date().format(.DDMMMYYYY))
          .navigationBarItems(trailing: SortButton(viewModel: viewModel))
       )
      default:
        return AnyView(Text("Nothing"))
      }
    }
  }
}

struct PlanDateView_Previews: PreviewProvider {
  static var previews: some View {
    CountryCasesView(viewModel: CountryCasesViewModel(repository: CovidRepository()))
  }
}
