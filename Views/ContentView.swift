import SwiftUI

struct ContentView: View {
    @StateObject private var brightnessManager = BrightnessManager.shared
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                // Mode Toggle
                HStack {
                    Text("Mode")
                        .font(.headline)
                    Spacer()
                    Picker("Time Mode", selection: $brightnessManager.timeMode) {
                        Text("Day").tag(TimeMode.day)
                        Text("Night").tag(TimeMode.night)
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 150)
                }
                .padding(.horizontal)
                
                // Preset Modes
                VStack(alignment: .leading, spacing: 20) {
                    Text("Preset Modes")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    ForEach(PresetModes.shared.allModes, id: \.name) { mode in
                        ModeButton(mode: mode, isSelected: brightnessManager.currentMode.name == mode.name) {
                            brightnessManager.applyMode(mode)
                        }
                    }
                }
                
                // Manual Controls
                VStack(spacing: 20) {
                    BrightnessControl()
                    ColorTemperatureControl()
                }
                .padding(.top)
                
                Spacer()
            }
            .padding(.vertical)
            .navigationTitle("Screen Control")
        }
    }
}

struct ModeButton: View {
    let mode: PresetMode
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(mode.icon)
                    .font(.title)
                Text(mode.name)
                    .font(.headline)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.horizontal)
    }
}

struct BrightnessControl: View {
    @StateObject private var brightnessManager = BrightnessManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "sun.min")
                Slider(value: $brightnessManager.currentBrightness, in: 0...1)
                Image(systemName: "sun.max")
            }
            .padding(.horizontal)
        }
    }
}

struct ColorTemperatureControl: View {
    @StateObject private var brightnessManager = BrightnessManager.shared
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "thermometer.sun")
                Slider(value: $brightnessManager.currentColorTemperature, in: 0...1)
                Image(systemName: "thermometer.sun.fill")
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ContentView()
}