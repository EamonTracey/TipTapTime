import SwiftUI
import NomaePreferences

let identifier = "com.eamontracey.tiptaptime"

struct RootPreferences: View {
    @Preference("enabled", identifier: identifier) private var enabled = true
    
    var body: some View {
        Form {
            Header("TipTapTime", icon: Image.tipTapTime, subtitle: "Developed by Eamon Tracey")
            Section(header: Text("Enable/Disable")) {
                Toggle("Enable", isOn: $enabled)
            }
            if enabled {
                Section(header: Text("Time & Date")) {
                    NavigationLink("Time", destination: TimePreferences())
                    NavigationLink("Date", destination: DatePreferences())
                }
            }
            Section(footer: Text("Required to affectuate changes")) {
                HStack {
                    Image(systemName: "xmark.shield")
                    Button("Respring", action: respring)
                }
                .foregroundColor(.red)
            }
            Section(footer: Text("HUGE thank you and credits to Dimitar Nestorov for his work creating the original implementation of TipTapTime\n\n© Eamon Tracey 2021").multilineTextAlignment(.center)) {
                HStack {
                    Image(contentsOfFile: "/Library/PreferenceBundles/TipTapTimePreferences.bundle/github@3x.png")
                    Button("Source Code  ❤️  Leave a  ⭐️") {
                        UIApplication.shared.open(URL(string: "https://github.com/EamonTracey/TipTapTime")!, options: .init(), completionHandler: .none)
                    }
                }
            }
        }
        .navigationBarTitle("TipTapTime")
        .environment(\.horizontalSizeClass, .regular)
    }
}

private func respring() {
    let task = (NSClassFromString("NSTask") as? NSObject.Type)?.init()
    task?.perform(Selector(("setLaunchPath:")), with: "/usr/bin/sbreload")
    task?.perform(Selector(("launch")))
}

private extension Image {
    
    init?(contentsOfFile path: String) {
        guard let uiImage = UIImage(contentsOfFile: path) else { return nil }
        self.init(uiImage: uiImage)
    }
    
    static var tipTapTime: some View {
        (Image(contentsOfFile: "/Library/PreferenceBundles/TipTapTimePreferences.bundle/icon@3x.png") ?? Image(systemName: "clock"))
            .resizable()
            .frame(width: 64, height: 64)
    }
    
}
