import Foundation

struct CovidCase : Identifiable, Decodable {
  var id = UUID()
  var date: Date
  var recovered: Int
  var deaths: Int
  var confirmed: Int
  
  private enum CodingKeys: String, CodingKey {
    case date, recovered, deaths, confirmed
  }
}
