import SwiftUI
import SwiftUICharts

struct CountryHistorySuccessView: View {
   let viewModel: CountryHistorySuccessViewModel
    var body: some View {
      VStack {
        LineView(data: viewModel.deathValues,title: "Deaths")
          .frame(width: 300, height: 300, alignment: .center)
      }
    }
}

struct HistorySuccessView_Previews: PreviewProvider {
    static var previews: some View {
        CountryHistorySuccessView(viewModel: CountryHistorySuccessViewModel(recoveredValues: [], deathValues: [], infectedValues: []))
    }
}
