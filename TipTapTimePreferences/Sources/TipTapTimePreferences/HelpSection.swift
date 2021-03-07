import SwiftUI

struct HelpSection: View {
    var body: some View {
        Section(header: Text("Help")) {
            Button("Cheat Sheet") {
                UIApplication.shared.open(URL(string: "https://nsdateformatter.com")!, options: .init(), completionHandler: .none)
            }
            Button("Unicode LDML Documentation") {
                UIApplication.shared.open(URL(string: "https://unicode.org/reports/tr35/tr35-dates.html#Contents")!, options: .init(), completionHandler: .none)
            }
        }
    }
}
