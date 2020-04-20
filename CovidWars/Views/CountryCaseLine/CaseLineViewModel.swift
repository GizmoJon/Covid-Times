import Foundation

class CaseLineVieModel: ObservableObject {
  let countryName: String
  let covidCases: [CovidCase]
  
  init(countryName: String,
       covidCases: [CovidCase]) {
    self.countryName = countryName
    self.covidCases = covidCases
  }
  
  var confirmed: Int {
    return covidCases.last?.confirmed ?? 0
  }
  
  var deaths: Int {
    return covidCases.last?.deaths ?? 0
  }
  
  var recovered: Int {
    return covidCases.last?.recovered ?? 0
  }
  
  var growthDead: Int {
    guard let lastCase = covidCases.last,
      let beforelastCase = covidCases.dropLast().last else { return 0 }
    return lastCase.deaths - beforelastCase.deaths
  }
  
  var growthRecovered: Int {
    guard let lastCase = covidCases.last,
      let beforelastCase = covidCases.dropLast().last else { return 0 }
    return lastCase.recovered - beforelastCase.recovered
  }
  
  var growthConfirmed: Int {
    guard let lastCase = covidCases.last,
      let beforelastCase = covidCases.dropLast().last else { return 0 }
    return lastCase.confirmed - beforelastCase.confirmed
  }
}

extension CaseLineVieModel: Hashable {
  static func == (lhs: CaseLineVieModel, rhs: CaseLineVieModel) -> Bool {
    return lhs.countryName == rhs.countryName
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.countryName)
  }
}
