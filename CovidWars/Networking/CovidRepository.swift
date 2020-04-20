import Foundation
import Combine

protocol CovidRepoFetchable {
  func getCurrentCountryCases() -> AnyPublisher<Dictionary<String,[CovidCase]>, CovidRepoError>
}

class CovidRepository: CovidRepoFetchable {
  func getCurrentCountryCases() -> AnyPublisher<Dictionary<String,[CovidCase]>, CovidRepoError> {
    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsURL.appendingPathComponent("covidData.json")
    return URLSession.shared.dataTaskPublisher(for: URLRequest(url: fileURL))
      .mapError { error in
        return .parsing(description: "parsingFailed")
      }
      .flatMap(maxPublishers: .max(1)) { pair in
        decode(pair.data)
      }
      .eraseToAnyPublisher()
  }
}
