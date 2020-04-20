import Foundation

enum CountryHistoryViewModelState {
  case success(CountryHistorySuccessViewModel)
}

class CountryHistoryViewModel: ObservableObject {
  @Published var state: CountryHistoryViewModelState
  
  init(with cases: [CovidCase]) {
    let recoveredValues = cases.compactMap{Double($0.recovered)}
    let deathValues = cases.compactMap{Double($0.deaths)}
    let invectedValues = cases.compactMap{Double($0.confirmed)}
    
    let viewModel = CountryHistorySuccessViewModel(recoveredValues: recoveredValues,
                                                   deathValues: deathValues,
                                                   infectedValues: invectedValues)
    state = .success(viewModel)
  }
}

class CountryHistorySuccessViewModel {
  var recoveredValues: [Double] = []
  var infectedValues: [Double] = []
  var deathValues: [Double] = []
  
  init(recoveredValues: [Double],
       deathValues: [Double],
       infectedValues: [Double]) {
    self.recoveredValues = recoveredValues
    self.deathValues = deathValues
    self.infectedValues = infectedValues
  }
}
