//
//  ContentView.swift
//  Display3DObject
//
//  Created by MyMac on 30/04/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @ObservedObject var appData: AppData
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false

    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack {
            VStack {
                Toggle("Show Objects", isOn: $showImmersiveSpace)
                    .font(.largeTitle)
                    .frame(width: 550)
                    .padding(24)
                    .glassBackgroundEffect()
            }
            .padding(24)
            
            VStack (spacing: 25) {
                VStack {
                    HStack {
                        Text("Scale")
                            .font(.largeTitle)
                            .padding(.trailing)
                        Slider(value: $appData.objectScale, in: 0.01...0.5) {}
                            .controlSize(.extraLarge)
                        Text("\(appData.objectScale, specifier: "%.2f")")
                            .font(.largeTitle)
                            .padding(.leading)
                    }
                }
                .frame(width: 550)
                .padding(24)
                .glassBackgroundEffect()
                
                VStack {
                    HStack {
                        Text("Distance")
                            .font(.largeTitle)
                            .padding(.trailing)
                        Slider(value: $appData.objectDistance, in: 10.0...100.0) {}
                            .controlSize(.extraLarge)
                        Text("\(appData.objectDistance, specifier: "%.2f")")
                            .font(.largeTitle)
                            .padding(.leading)
                    }
                }
                .frame(width: 550)
                .padding(24)
                .glassBackgroundEffect()
                
                VStack {
                    HStack {
                        Text("Up-Down")
                            .font(.largeTitle)
                            .padding(.trailing)
                        Slider(value: $appData.objectUpDown, in: 0.0...100.0) {}
                            .controlSize(.extraLarge)
                        Text("\(appData.objectUpDown, specifier: "%.2f")")
                            .font(.largeTitle)
                            .padding(.leading)
                    }
                }
                .frame(width: 550)
                .padding(24)
                .glassBackgroundEffect()
            }
            .frame(width: 600)
            .padding(36)
        }
        .padding(30)
        .glassBackgroundEffect()
        .onChange(of: showImmersiveSpace) { _, newValue in
            Task {
                if newValue {
                    switch await openImmersiveSpace(id: "ImmersiveSpace") {
                    case .opened:
                        immersiveSpaceIsShown = true
                    case .error, .userCancelled:
                        fallthrough
                    @unknown default:
                        immersiveSpaceIsShown = false
                        showImmersiveSpace = false
                    }
                } else if immersiveSpaceIsShown {
                    await dismissImmersiveSpace()
                    immersiveSpaceIsShown = false
                }
            }
        }
    }
}

#Preview(windowStyle: .volumetric) {
    ContentView(appData: AppData())
}
