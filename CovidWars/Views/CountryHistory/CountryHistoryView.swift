import SwiftUI
import SwiftUICharts

struct CountryHistoryView: View {
  @ObservedObject var viewModel: CountryHistoryViewModel
  
  var body: some View {
    switch viewModel.state {
    case .success(let viewModel):
      return AnyView(CountryHistorySuccessView(viewModel: viewModel))
    }
  }
}

struct CountryHistory_Previews: PreviewProvider {
  static var previews: some View {
    let viewModel = CountryHistoryViewModel(with: [])
    return CountryHistoryView(viewModel: viewModel)
  }
}
