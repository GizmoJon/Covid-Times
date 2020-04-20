import Foundation
import BackgroundTasks
import NotificationCenter

class DataSyncOperation: Operation {
  override func main() {
    DataSyncService().sync()
  }
}

protocol BackgroundTaskManagement {
  func registerBackgroundTasks()
  func registerLocalNotification()
}

class TaskManager: BackgroundTaskManagement {
  func registerBackgroundTasks() {
    BGTaskScheduler.shared.register( forTaskWithIdentifier: "covidWars.refresh",
                                     using: nil) { task in
      self.handleAppRefresh(task)
    }
  }
  
  private func handleAppRefresh(_ task: BGTask) {
    debugPrint("handling app refresh")
    
    let queue = OperationQueue()
    queue.maxConcurrentOperationCount = 1
    
    let dataSyncOperation = DataSyncOperation()
    dataSyncOperation.completionBlock = {
      debugPrint("sync done")
    }
    queue.addOperation(dataSyncOperation)
    
    queue.addOperation {
      NotificationService().scheduleNotification(statsBody: "Bla")
    }
    
    task.expirationHandler = {
      debugPrint("expired operation")
      queue.cancelAllOperations()
    }
    
    let lastOperation = queue.operations.last
    lastOperation?.completionBlock = {
      task.setTaskCompleted(success: !(lastOperation?.isCancelled ?? false))
    }
    scheduleAppRefresh()
  }
  
  private func scheduleAppRefresh() {
    do {
      let request = BGAppRefreshTaskRequest(identifier: "covidWars.refresh")
      request.earliestBeginDate = Date(timeIntervalSinceNow: 10)
      try BGTaskScheduler.shared.submit(request)
    } catch {
      print(error)
    }
  }
}

extension TaskManager {
  func registerLocalNotification() {
    let notificationCenter = UNUserNotificationCenter.current()
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    
    notificationCenter.requestAuthorization(options: options) { (didAllow, error) in
      if !didAllow {
        print("User has declined notifications")
      } else {
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }
  }
}
