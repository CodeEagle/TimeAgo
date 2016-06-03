import Foundation

extension String {
	public func toDateWith(format: String) -> NSDate {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.dateFromString(self) ?? NSDate()
	}
}

public class TimeAgo: NSObject {

	public class Words: NSObject {
		var yearsAgo = " year(s) ago"
		var monthsAgo = " month(s) ago"
		var weeksAgo = " week(s) ago"
		var daysAgo = " day(s) ago"
		var hoursAgo = " hours ago"
		var anHourAgo = "An hour ago"
		var minutesAgo = " minutes ago"
		var anMinuteAgo = "A minute ago"
		var secondsAgo = " seconds ago"
		var justNow = "Just now"

		public override init() { super.init() }

		public convenience init(yearsAgo: String, monthsAgo: String, weeksAgo: String, daysAgo: String, hoursAgo: String, anHourAgo: String, minutesAgo: String, anMinuteAgo: String, secondsAgo: String, justNow: String) {
			self.init()
			self.yearsAgo = yearsAgo
			self.monthsAgo = monthsAgo
			self.weeksAgo = weeksAgo
			self.daysAgo = daysAgo
			self.hoursAgo = hoursAgo
			self.anHourAgo = anHourAgo
			self.minutesAgo = minutesAgo
			self.anMinuteAgo = anMinuteAgo
			self.secondsAgo = secondsAgo
			self.justNow = justNow
		}
	}

	public static let manager = TimeAgo()

	private override init() {
		super.init()
		let zhhans = Words(yearsAgo: "年前", monthsAgo: "个月前", weeksAgo: "星期前", daysAgo: "天前", hoursAgo: "小时前", anHourAgo: "1小时前", minutesAgo: "分钟前", anMinuteAgo: "1分钟前", secondsAgo: "秒钟前", justNow: "刚刚")

		let zhhant = Words(yearsAgo: "年前", monthsAgo: "個月前", weeksAgo: "星期前", daysAgo: "天前", hoursAgo: "小時前", anHourAgo: "1小時前", minutesAgo: "分鐘前", anMinuteAgo: "1分鐘前", secondsAgo: "秒鐘前", justNow: "剛剛")
		let en = Words()
		configureForCustomWords["zh-Hans"] = zhhans
		configureForCustomWords["zh-Hant"] = zhhant
		configureForCustomWords["en_US"] = en
	}

	public var configureForCustomWords: [String: Words] = [:]
	public var currentLanguage: String = "en_US"

	var config: Words {
		if let v = configureForCustomWords[currentLanguage] {
			return v
		}
		return Words()
	}
}
extension NSDate {
	/*
	 let date = NSDate()
	 let after = date.dateByAddingTimeInterval(10)
	 let before = date.dateByAddingTimeInterval(-10)
	 let a = date.compare(after) == .OrderedAscending //true
	 let b = date.compare(before) == .OrderedDescending //true
	 */
	public func isEarlierThan(date: NSDate) -> Bool {
		return compare(date) == .OrderedAscending
	}

	public func isEarlierThanOrEqualTo(date: NSDate) -> Bool {
		let result = compare(date)
		return result == .OrderedAscending || result == .OrderedSame
	}

	public func formattedDateWith(format: String) -> String {
		let dateFormatter = NSDateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.stringFromDate(self)
	}

	public func dayBetweenNow() -> String {
		let endDate = NSDate()
		let cal = NSCalendar.currentCalendar()
		let components = cal.components(.Day, fromDate: self, toDate: endDate, options: .MatchFirst)
		return "\(components.day)"
	}

	public func timeAgoSinceNow() -> String {
		let calendar = NSCalendar.currentCalendar()
		let now = NSDate()
		let unitFlags: NSCalendarUnit = [.Second, .Minute, .Hour, .Day, .WeekOfYear, .Month, .Year]
		let components = calendar.components(unitFlags, fromDate: self, toDate: now, options: [])

		let config = TimeAgo.manager.config

		if components.year >= 1 { return "\(components.year)" + config.yearsAgo }
		if components.month >= 1 { return "\(components.month)" + config.monthsAgo }
		if components.weekOfYear >= 1 { return "\(components.weekOfYear)" + config.weeksAgo }
		if components.day >= 1 { return "\(components.day)" + config.daysAgo }
		if components.hour >= 2 { return "\(components.hour)" + config.hoursAgo }
		if components.hour >= 1 { return config.anHourAgo }
		if components.minute >= 2 { return "\(components.minute)" + config.minutesAgo }
		if components.minute >= 1 { return config.anMinuteAgo }
		if components.second >= 3 { return "\(components.second)" + config.secondsAgo }
		return config.justNow
	}
}

