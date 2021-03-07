import SwiftUI
import NomaePreferences

struct TimePreferences: View {
    @Preference("showAMPM", identifier: identifier) private var showAMPM = true
    @Preference("militaryTime", identifier: identifier) private var militaryTime = false
    @Preference("timeCustomFormatEnabled", identifier: identifier) private var timeCustomFormatEnabled = false
    @Preference("timeCustomStringEnabled", identifier: identifier) private var timeCustomStringEnabled = false
    @Preference("timeCustomFormat", identifier: identifier) private var timeCustomFormat = ""
    @Preference("timeCustomString", identifier: identifier) private var timeCustomString = ""
    
    private var timeString: String {
        if timeCustomStringEnabled {
            return timeCustomString
        }
        let formatter = DateFormatter()
        if timeCustomFormatEnabled {
            formatter.dateFormat = timeCustomFormat
            return formatter.string(from: Date())
        }
        var format = ""
        format += militaryTime ? "H:mm" : "h:mm"
        format += showAMPM ? " a" : ""
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Text(timeString)
                        .font(.title)
                    Spacer()
                }
                .padding(.vertical)
            }
            if !timeCustomFormatEnabled && !timeCustomStringEnabled {
                Section(header: Text("Basic")) {
                    Toggle("Show AM/PM", isOn: $showAMPM)
                    Toggle("Military Time", isOn: $militaryTime)
                }
            }
            Section(header: Text("Advanced")) {
                if !timeCustomStringEnabled {
                    Toggle("Custom Date/Time Format", isOn: $timeCustomFormatEnabled)
                }
                if !timeCustomFormatEnabled {
                    Toggle("Custom String", isOn: $timeCustomStringEnabled)
                }
                if timeCustomFormatEnabled {
                    TextField("Format", text: $timeCustomFormat)
                }
                if timeCustomStringEnabled {
                    TextField("String", text: $timeCustomString)
                }
            }
            if timeCustomFormatEnabled {
                HelpSection()
            }
        }
        .navigationBarTitle("Time")
        .environment(\.horizontalSizeClass, .regular)
    }
}
