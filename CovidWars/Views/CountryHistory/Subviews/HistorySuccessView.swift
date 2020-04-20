import SwiftUI
import SwiftUICharts

struct CountryHistory_Success_View: View {
   let viewModel: CountryHistorySuccessViewModel
    var body: some View {
      VStack {
        MultiLineChartView(data: [(viewModel.deathValues, GradientColors.green), (viewModel.infectedValues, GradientColors.purple), (viewModel.recoveredValues, GradientColors.orngPink)], title: "Title")
      }
    }
}

struct HistorySuccessView_Previews: PreviewProvider {
    static var previews: some View {
        CountryHistory_Success_View(viewModel: CountryHistorySuccessViewModel(recoveredValues: [], deathValues: [], infectedValues: []))
    }
}
