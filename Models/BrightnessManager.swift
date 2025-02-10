import UIKit
import CoreImage

class BrightnessManager: ObservableObject {
    static let shared = BrightnessManager()
    
    @Published var currentBrightness: CGFloat {
        didSet {
            UIScreen.main.brightness = currentBrightness
        }
    }
    @Published var currentColorTemperature: Double
    @Published var currentMode: PresetMode
    @Published var timeMode: TimeMode {
        didSet {
            PresetModes.shared.saveTimeMode(timeMode)
            applySettings()
        }
    }
    
    private init() {
        self.currentBrightness = UIScreen.main.brightness
        self.currentColorTemperature = 0.5
        self.currentMode = PresetModes.shared.getLastMode()
        self.timeMode = PresetModes.shared.getTimeMode()
    }
    
    func applyMode(_ mode: PresetMode) {
        currentMode = mode
        PresetModes.shared.saveLastMode(mode)
        applySettings()
    }
    
    private func applySettings() {
        let settings = timeMode == .day ? currentMode.daySettings : currentMode.nightSettings
        currentBrightness = settings.brightness
        currentColorTemperature = settings.colorTemperature
        
        // Apply color temperature using Core Image filter
        applyColorTemperature()
    }
    
    private func applyColorTemperature() {
        // Note: This is a simplified implementation
        // In a real app, you would need to implement proper color temperature
        // adjustment using CIFilter or Night Shift API if available
        
        // For demonstration, we're just setting the brightness
        // The actual color temperature implementation would require
        // additional system-level permissions or private APIs
    }
}