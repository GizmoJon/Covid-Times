import Foundation
import Combine

enum CountryCasesViewModelState {
  case idle
  case loading
  case success([CaseLineVieModel])
  case failure(Error)
}

class CountryCasesViewModel: ObservableObject {
  @Published var state: CountryCasesViewModelState
  @Published var sortType: SortType = .alphabetically
  
  private var countryCases: [CaseLineVieModel] = [] {
    didSet {
      self.state = .success(countryCases)
    }
  }

  let repostiory: CovidRepoFetchable
  private var disposables = Set<AnyCancellable>()
  
  init(repository: CovidRepoFetchable) {
    self.repostiory = repository
    self.state = .idle
    
    $sortType
      .sink { type in
        self.countryCases = self.countryCases.sort(with: type)
    }
    .store(in: &disposables)
  }
  
  func getCountries() {
    state = .loading
    repostiory.getCurrentCountryCases()
      .map { response in
        response.map{CaseLineVieModel(countryName: $0.key, covidCases: $0.value)}
    }
    .map { viewModels in
      return viewModels.sort(with: .alphabetically)
    }
    .receive(on: DispatchQueue.main)
    .sink(
      receiveCompletion: { [weak self] value in
        guard let self = self else { return }
        switch value {
        case .failure(let error):
          self.state = .failure(error)
        case .finished:
          break
        }
      },
      receiveValue: { [weak self] countryCases in
        guard let self = self else { return }
        self.countryCases = countryCases
    })
     .store(in: &disposables)
  }
}

extension Array where Element == CaseLineVieModel {
  func sort(with type: CountryCasesViewModel.SortType) -> Self {
    return self.sorted(by: { country1, country2  in
      return type.sortComparator(element1: country1, element2: country2)
    })
  }
}
