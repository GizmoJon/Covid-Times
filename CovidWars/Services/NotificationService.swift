import Foundation
import NotificationCenter

class NotificationService {
  func scheduleNotification(statsBody: String) {
    let identifier: String = "covid19.stats"
    let app = UIApplication.shared
    let content = UNMutableNotificationContent()
    content.title = "Covid-19.stats"
    content.body = statsBody
    content.sound = UNNotificationSound.default
    content.badge = NSNumber(value: app.applicationIconBadgeNumber + 1)
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0,
                                                    repeats: false)
    let request = UNNotificationRequest(identifier: identifier,
                                        content: content,
                                        trigger: trigger)
    UNUserNotificationCenter.current().add(request)
  }
  
  func removePreviousScheduleNotifications() {
    UNUserNotificationCenter.current()
      .removeDeliveredNotifications(withIdentifiers: ["covid19.stats"])
  }
}
