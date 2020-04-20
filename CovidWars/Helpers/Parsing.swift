import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, CovidRepoError> {
  let decoder = JSONDecoder()
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-M-dd"
      decoder.dateDecodingStrategy = .formatted(formatter)

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
