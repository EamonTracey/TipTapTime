import TipTapTimeC

class DimitarStatusBarStringView: _UIStatusBarStringView {

    override var text: String? {
        get { super.text }
        set { super.text = craftString() }
    }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tiptaptime_handleTap(sender:)))
        addGestureRecognizer(tapGestureRecognizer)
    }

    func craftString() -> String {
        return TT._dateShowing ? craftDateString() : craftTimeString()
    }

    func craftTimeString() -> String {
        if TT.timeCustomStringEnabled {
            return TT.timeCustomString
        }
        let formatter = DateFormatter()
        if TT.timeCustomFormatEnabled {
            formatter.dateFormat = TT.timeCustomFormat
            return formatter.string(from: Date())
        }
        var format = ""
        format += TT.militaryTime ? "H:mm" : "h:mm"
        format += TT.showAMPM ? " a" : ""
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }

    func craftDateString() -> String {
        if TT.dateCustomStringEnabled {
            return TT.dateCustomString
        }
        let formatter = DateFormatter()
        if TT.dateCustomFormatEnabled {
            formatter.dateFormat = TT.dateCustomFormat
            return formatter.string(from: Date())
        }
        var format = ""
        format += TT.dayBeforeMonth ? "d M" : "M d"
        format += TT.showYear ? " Y" : ""
        format = format.replacingOccurrences(of: " ", with: TT.dateSeparator)
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }

    @objc func tiptaptime_handleTap(sender: UITapGestureRecognizer? = nil) {
        TT._dateShowing.toggle()
        let userInfo = ["dateShowing": TT._dateShowing]
        NotificationCenter.default.post(name: TT.tappedNotificationName, object: nil, userInfo: userInfo)
    }

}
