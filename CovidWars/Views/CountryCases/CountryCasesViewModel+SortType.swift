import Foundation

extension CountryCasesViewModel {
  enum SortType {
    case alphabetically
    case byDeaths
    case byConfirmed
    
    func sortComparator(element1: CaseLineVieModel, element2: CaseLineVieModel) -> Bool {
      
      switch self {
      case .alphabetically:
        return element1.countryName < element2.countryName
        
      case .byConfirmed:
        guard let lastCovidCase1 = element1.covidCases.last,
          let lastCovidCase2 = element2.covidCases.last else { return false}
        return lastCovidCase1.confirmed > lastCovidCase2.confirmed
        
      case .byDeaths :
        guard let lastCovidCase1 = element1.covidCases.last,
          let lastCovidCase2 = element2.covidCases.last else { return false}
        return lastCovidCase1.deaths > lastCovidCase2.deaths
      }
    }
  }
}
