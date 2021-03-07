import Orion
import NomaePreferences
import TipTapTimeC

typealias TT = TipTapTime

struct TipTapTime: Tweak {

    static let identifier = "com.eamontracey.tiptaptime"

    // Preferences
    @Preference("enabled", identifier: identifier) static var enabled = true
    @Preference("showAMPM", identifier: identifier) static var showAMPM = true
    @Preference("militaryTime", identifier: identifier) static var militaryTime = false
    @Preference("timeCustomFormatEnabled", identifier: identifier) static var timeCustomFormatEnabled = false
    @Preference("timeCustomStringEnabled", identifier: identifier) static var timeCustomStringEnabled = false
    @Preference("timeCustomFormat", identifier: identifier) static var timeCustomFormat = ""
    @Preference("timeCustomString", identifier: identifier) static var timeCustomString = ""
    @Preference("dateSeparator", identifier: identifier) static var dateSeparator = "/"
    @Preference("showYear", identifier: identifier) static var showYear = true
    @Preference("dayBeforeMonth", identifier: identifier) static var dayBeforeMonth = false
    @Preference("dateCustomFormatEnabled", identifier: identifier) static var dateCustomFormatEnabled = false
    @Preference("dateCustomStringEnabled", identifier: identifier) static var dateCustomStringEnabled = false
    @Preference("dateCustomFormat", identifier: identifier) static var dateCustomFormat = ""
    @Preference("dateCustomString", identifier: identifier) static var dateCustomString = ""

    // Globals
    @Preference("_dateShowing", identifier: identifier) static var _dateShowing = false
    static let tappedNotificationName = NSNotification.Name(rawValue: "com.eamontracey.tiptaptime/tap")

}

class UIStatusBarTimeItemHook: ClassHook<_UIStatusBarTimeItem> {

    static func hookWillActivate() -> Bool {
        return TT.enabled
    }

    func initWithIdentifier(_ identifier: Any?, statusBar: Any?) {
        orig.initWithIdentifier(identifier, statusBar: statusBar)
        NotificationCenter.default.addObserver(target, selector: #selector(self.tiptaptime_handleTap(notification:)), name: TT.tappedNotificationName, object: nil)
    }

    func _create_timeView() {
        orig._create_timeView()
        object_setClass(target.timeView, DimitarStatusBarStringView.self)
    }

    func _create_shortTimeView() {
        orig._create_shortTimeView()
        object_setClass(target.shortTimeView, DimitarStatusBarStringView.self)
    }

    func _create_pillTimeView() {
        orig._create_pillTimeView()
        object_setClass(target.pillTimeView, DimitarStatusBarStringView.self)
    }

    func _create_dateView() {
        orig._create_dateView()
        object_setClass(target.dateView, DimitarStatusBarStringView.self)
    }

    @objc final func tiptaptime_handleTap(notification: Notification) {
        if let userInfo = notification.userInfo, let dateShowing = userInfo["dateShowing"] as? Bool {
            TT._dateShowing = dateShowing
        }
        // Call setters to force update
        target.timeView.text = nil
        target.shortTimeView.text = nil
        target.pillTimeView.text = nil
        target.dateView.text = nil
    }

}
