import Foundation

extension String {
	public func toDateWith(_ format: String) -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.date(from: self) ?? Date()
	}
}

open class TimeAgo: NSObject {

	open class Words: NSObject {
        var yearAgo = " year ago"
		var yearsAgo = " years ago"
        var monthAgo = " month ago"
		var monthsAgo = " months ago"
        var weekAgo = " week ago"
		var weeksAgo = " weeks ago"
        var dayAgo = " day ago"
		var daysAgo = " days ago"
		var hoursAgo = " hours ago"
		var anHourAgo = "An hour ago"
		var minutesAgo = " minutes ago"
		var anMinuteAgo = "A minute ago"
		var secondsAgo = " seconds ago"
        var justNow = "Just now"
        var yesterday = "Yesterday"
        var theDayBeforeYesterday = "The day before yesterday"

		public override init() { super.init() }

        public convenience init(yearsAgo: String, yearAgo: String, monthsAgo: String, monthAgo: String, weeksAgo: String, weekAgo: String, daysAgo: String, dayAgo: String, hoursAgo: String, anHourAgo: String, minutesAgo: String, anMinuteAgo: String, secondsAgo: String, justNow: String, yesterday: String, theDayBeforeYesterday: String) {
			self.init()
			self.yearsAgo = yearsAgo
            self.yearAgo = yearAgo
			self.monthsAgo = monthsAgo
            self.monthAgo = monthAgo
			self.weeksAgo = weeksAgo
            self.weekAgo = weekAgo
			self.daysAgo = daysAgo
            self.dayAgo = dayAgo
			self.hoursAgo = hoursAgo
			self.anHourAgo = anHourAgo
			self.minutesAgo = minutesAgo
			self.anMinuteAgo = anMinuteAgo
			self.secondsAgo = secondsAgo
            self.justNow = justNow
            self.yesterday = yesterday
            self.theDayBeforeYesterday = theDayBeforeYesterday
		}
	}

	open static let manager = TimeAgo()

	fileprivate override init() {
		super.init()
		let zhhans = Words(yearsAgo: "年前", yearAgo: "年前", monthsAgo: "个月前", monthAgo: "个月前", weeksAgo: "星期前", weekAgo: "星期前", daysAgo: "天前", dayAgo: "天前", hoursAgo: "小时前", anHourAgo: "1小时前", minutesAgo: "分钟前", anMinuteAgo: "1分钟前", secondsAgo: "秒钟前", justNow: "刚刚", yesterday: "昨天", theDayBeforeYesterday: "前天")

        let zhhant = Words(yearsAgo: "年前", yearAgo: "年前", monthsAgo: "個月前", monthAgo: "個月前", weeksAgo: "星期前", weekAgo: "星期前", daysAgo: "天前", dayAgo: "天前", hoursAgo: "小時前", anHourAgo: "1小時前", minutesAgo: "分鐘前", anMinuteAgo: "1分鐘前", secondsAgo: "秒鐘前", justNow: "剛剛", yesterday: "昨天", theDayBeforeYesterday: "前天")
		let en = Words()
		configureForCustomWords["zh-Hans"] = zhhans
		configureForCustomWords["zh-Hant"] = zhhant
		configureForCustomWords["en_US"] = en
	}

	open var configureForCustomWords: [String: Words] = [:]
	open var currentLanguage: String = "en_US"

	var config: Words {
		if let v = configureForCustomWords[currentLanguage] {
			return v
		}
		return Words()
	}
}
extension Date {
	/*
	 let date = NSDate()
	 let after = date.dateByAddingTimeInterval(10)
	 let before = date.dateByAddingTimeInterval(-10)
	 let a = date.compare(after) == .OrderedAscending //true
	 let b = date.compare(before) == .OrderedDescending //true
	 */
	public func isEarlierThan(_ date: Date) -> Bool {
		return compare(date) == .orderedAscending
	}

	public func isEarlierThanOrEqualTo(_ date: Date) -> Bool {
		let result = compare(date)
		return result == .orderedAscending || result == .orderedSame
	}

	public func formattedDateWith(_ format: String) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: self)
	}

	public func dayBetweenNow() -> String {
		let endDate = Date()
		let cal = Calendar.current
		let components = (cal as NSCalendar).components(.day, from: self, to: endDate, options: .matchFirst)
		return "\(components.day)"
	}

    public func timeAgoSinceNow() -> String {
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])
        
        let dateCom = (calendar as NSCalendar).components([.day, .month, .year], from: self)
        let currentCom = (calendar as NSCalendar).components([.day, .month, .year], from: now)
        let config = TimeAgo.manager.config
        
        if ((currentCom.year ?? 0) - (dateCom.year ?? 0)) >= 1 {
            return self.formattedDateWith("yyyy-MM-dd")
        }
        
        if let d = components.day, d > 0 {
            if d > 5 {
                return self.formattedDateWith("MM-dd")
            } else if d >= 3 && d <= 5 {
                return "\(d)" + config.daysAgo
            } else if d >= 2 && d < 3 {
                return config.yesterday
            } else if d >= 1 && d < 2 {
                return config.theDayBeforeYesterday
            }
        }
        
        if let h = components.hour, h > 0 { return h > 1 ? ("\(h)" + config.hoursAgo) : config.anHourAgo }
        if let m = components.minute, m > 0 { return m > 1 ? ("\(m)" + config.minutesAgo) : config.anMinuteAgo }
        return config.justNow
    }
    
    public func timeAgoSinceNowForChat() -> String {
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: self, to: now, options: [])
        
        let config = TimeAgo.manager.config
        
        if let y = components.year, y > 0 { return  "\(y)" + (y > 1 ? config.yearsAgo : config.yearAgo) }
        if let m = components.month, m > 0 { return "\(m)" + (m > 1 ? config.monthsAgo : config.monthAgo) }
        if let w = components.weekOfYear, w > 0 { return "\(w)" + (w > 1 ? config.weeksAgo : config.weekAgo) }
        if let d = components.day, d > 0 { return "\(d)" + (d > 1 ? config.daysAgo : config.dayAgo) }
        if let h = components.hour, h > 0 { return h > 1 ? ("\(h)" + config.hoursAgo) : config.anHourAgo }
        if let m = components.minute, m > 0 { return m > 1 ? ("\(m)" + config.minutesAgo) : config.anMinuteAgo }
        if let s = components.second, s >= 3 { return "\(s)" + config.secondsAgo }
        return config.justNow
    }
}

