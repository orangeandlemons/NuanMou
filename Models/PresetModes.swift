import Foundation
import UIKit

struct ScreenSettings {
    let brightness: CGFloat
    let colorTemperature: Double // 0.0 (cool) to 1.0 (warm)
}

enum TimeMode {
    case day
    case night
}

struct PresetMode {
    let name: String
    let icon: String
    let daySettings: ScreenSettings
    let nightSettings: ScreenSettings
}

class PresetModes {
    static let shared = PresetModes()
    
    let readingMode = PresetMode(
        name: "Reading",
        icon: "📖",
        daySettings: ScreenSettings(brightness: 0.6, colorTemperature: 0.7),
        nightSettings: ScreenSettings(brightness: 0.3, colorTemperature: 0.9)
    )
    
    let videoMode = PresetMode(
        name: "Video",
        icon: "🎬",
        daySettings: ScreenSettings(brightness: 0.8, colorTemperature: 0.5),
        nightSettings: ScreenSettings(brightness: 0.4, colorTemperature: 0.6)
    )
    
    let gamingMode = PresetMode(
        name: "Gaming",
        icon: "🎮",
        daySettings: ScreenSettings(brightness: 0.9, colorTemperature: 0.3),
        nightSettings: ScreenSettings(brightness: 0.6, colorTemperature: 0.5)
    )
    
    var allModes: [PresetMode] {
        [readingMode, videoMode, gamingMode]
    }
    
    // UserDefaults keys
    private let lastModePrefKey = "lastSelectedMode"
    private let timeModeKey = "timeMode"
    
    // Get and set last used mode
    func saveLastMode(_ mode: PresetMode) {
        UserDefaults.standard.set(mode.name, forKey: lastModePrefKey)
    }
    
    func getLastMode() -> PresetMode {
        let modeName = UserDefaults.standard.string(forKey: lastModePrefKey) ?? "Reading"
        return allModes.first { $0.name == modeName } ?? readingMode
    }
    
    func saveTimeMode(_ mode: TimeMode) {
        UserDefaults.standard.set(mode == .day ? "day" : "night", forKey: timeModeKey)
    }
    
    func getTimeMode() -> TimeMode {
        let mode = UserDefaults.standard.string(forKey: timeModeKey) ?? "day"
        return mode == "day" ? .day : .night
    }
}