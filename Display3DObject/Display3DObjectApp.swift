//
//  Display3DObjectApp.swift
//  Display3DObject
//
//  Created by MyMac on 30/04/24.
//

import SwiftUI

@main
struct Display3DObjectApp: App {
    @StateObject var appData: AppData = AppData()
    var body: some Scene {
        WindowGroup {
            ContentView(appData: appData)
        }
        .windowResizabilityContentSize()
        
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(appData: appData)
        }
    }
}

extension Scene {
    func windowResizabilityContentSize() -> some Scene {
        return windowResizability(.contentSize)
    }
}
