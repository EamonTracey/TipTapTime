import SwiftUI
import NomaePreferences

struct DatePreferences: View {
    @Preference("dateSeparator", identifier: identifier) private var dateSeparator = "/"
    @Preference("showYear", identifier: identifier) private var showYear = true
    @Preference("dayBeforeMonth", identifier: identifier) private var dayBeforeMonth = false
    @Preference("dateCustomFormatEnabled", identifier: identifier) private var dateCustomFormatEnabled = false
    @Preference("dateCustomStringEnabled", identifier: identifier) private var dateCustomStringEnabled = false
    @Preference("dateCustomFormat", identifier: identifier) private var dateCustomFormat = ""
    @Preference("dateCustomString", identifier: identifier) private var dateCustomString = ""
    
    private var dateString: String {
        if dateCustomStringEnabled {
            return dateCustomString
        }
        let formatter = DateFormatter()
        if dateCustomFormatEnabled {
            formatter.dateFormat = dateCustomFormat
            return formatter.string(from: Date())
        }
        var format = ""
        format += dayBeforeMonth ? "d M" : "M d"
        format += showYear ? " Y" : ""
        format = format.replacingOccurrences(of: " ", with: dateSeparator)
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
                    Text(dateString)
                        .font(.title)
                    Spacer()
                }
                .padding(.vertical)
            }
            if !dateCustomFormatEnabled && !dateCustomStringEnabled {
                Section(header: Text("Basic")) {
                    Picker("", selection: $dateSeparator) {
                        Text("/").tag("/")
                        Text("-").tag("-")
                        Text(".").tag(".")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Toggle("Show Year", isOn: $showYear)
                    Toggle("Day Before Month", isOn: $dayBeforeMonth)
                }
            }
            Section(header: Text("Advanced")) {
                if !dateCustomStringEnabled {
                    Toggle("Custom Date/Time Format", isOn: $dateCustomFormatEnabled)
                }
                if !dateCustomFormatEnabled {
                    Toggle("Custom String", isOn: $dateCustomStringEnabled)
                }
                if dateCustomFormatEnabled {
                    TextField("Format", text: $dateCustomFormat)
                }
                if dateCustomStringEnabled {
                    TextField("String", text: $dateCustomString)
                }
            }
            if dateCustomFormatEnabled {
                HelpSection()
            }
        }
        .navigationBarTitle("Date")
        .environment(\.horizontalSizeClass, .regular)
    }
}
