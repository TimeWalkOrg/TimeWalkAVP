//
//  AppData.swift
//  Display3DObject
//
//  Created by MyMac on 08/05/24.
//

import UIKit

class AppData: ObservableObject {
    @Published var objectScale: Double = 0.05
    @Published var objectDistance: Double = 20.0
    @Published var objectUpDown: Double = 0.0
}
