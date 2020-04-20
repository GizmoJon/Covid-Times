import Foundation

enum DateFormat: String {
    case HHmm = "HH:mm"
    case DDMMM = "dd MMM"
    case DDMMMYYYY = "dd/MM/YYYY"
    case DDMMMord = "dd 'de' MMMM"
    case DDMMMYYHHmm = "dd/MM/YY HH:mm"
}

extension Date {
    func format(_ format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }

    func utcString() -> String {
        let formatter = DateFormatter.aether()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        let utcTimeZoneStr = formatter.string(from: self)
        return utcTimeZoneStr
    }
}

extension DateFormatter {
    static func aether() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter
    }
}
