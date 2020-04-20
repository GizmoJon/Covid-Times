import Foundation

class DataSyncService: ObservableObject {
  struct Constants {
    static var expiryPeriod: Double { 3600 * 2 }
  }
  
  let urlString = "https://pomber.github.io/covid19/timeseries.json"
  
  @Published var loading: Bool = false
  @Published var syncComplete: Bool = false
  
  let syncGroup = DispatchGroup()
  
  func sync() {
    syncGroup.notify(qos: .default, queue: .main) {
      self.endSync()
    }
    
    guard isDataExpired else {
      endSync()
      return
    }
    
    fetchJsonFromRemote()
  }
  
  private func endSync() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.syncComplete = true
    }
  }
  
  var isDataExpired: Bool {
    if let jsonDate = getfileCreatedDate(theFile: "covidData.json") {
      return jsonDate.distance(to: Date()) > Constants.expiryPeriod
    }
    
    return true
  }
  
  func getfileCreatedDate(theFile: String) -> Date? {
    var theCreationDate = Date()
    do{
      
      let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let fileURL = documentsURL.appendingPathComponent("covidData.json")
      let aFileAttributes = try FileManager.default.attributesOfItem(atPath: fileURL.path) as [FileAttributeKey:Any]
      theCreationDate = aFileAttributes[FileAttributeKey.creationDate] as! Date
    } catch let error {
      debugPrint(error)
      return nil
    }
    return theCreationDate
  }
  
  private func fetchJsonFromRemote() {
    syncGroup.enter()
    guard let url:URL = URL(string: urlString) else {
      syncGroup.leave()
      
      return
    }
    
    let session = URLSession.shared
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: {
      (
      data, response, error) in
      
      guard let data = data, let _:URLResponse = response  , error == nil else {
        return
      }
      self.saveData(data)
    })
    task.resume()
  }
  
  private func saveData(_ data: Data) {
    do {
      let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      let fileURL = documentsURL.appendingPathComponent("covidData.json")
      try data.write(to: fileURL, options: .atomic)
      syncGroup.leave()
      
    } catch {
      syncGroup.leave()
    }
  }
}
