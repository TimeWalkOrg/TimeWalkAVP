//
//  ImmersiveView.swift
//  Display3DObject
//
//  Created by MyMac on 30/04/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @ObservedObject var appData: AppData
    @State var Statue_of_libertyEntity: Entity = {
        let headAnchor = AnchorEntity(world: .zero)
        headAnchor.name = "Statue_of_libertyEntity"
        headAnchor.position = [0, 0, 1]
        headAnchor.scale = [0.5, 0.5, 0.5]
        
//        headAnchor.position = [0, 0, 0]
//        let radians = -30 * Float.pi / 180
//        ImmersiveView.rotateEntityAroundYAxis(entity: headAnchor, angle: radians)
        return headAnchor
    }()
    
    @State var Jan_Martyn: Entity = {
        let headAnchor = AnchorEntity(world: .zero)
        headAnchor.name = "Jan_Martyn"
        headAnchor.position = [0, 0, -20]
        headAnchor.scale = [0.02, 0.02, 0.02]
        return headAnchor
    }()
    
    @State var Marten_Cregier: Entity = {
        let headAnchor = AnchorEntity(world: .zero)
        headAnchor.name = "Marten_Cregier"
        headAnchor.position = [20, 0, 0]
        headAnchor.scale = [0.02, 0.02, 0.02]
        return headAnchor
    }()
    
    var body: some View {
        RealityView { content in
            do {
                
                let entity = try await Entity(named: "Statue_of_liberty", in: realityKitContentBundle)
                entity.position = [0, 0, -5]
                entity.scale = [0.5, 0.5, 0.5]
                entity.synchronization?.ownershipTransferMode = .autoAccept

                content.add(entity)
                                
                let immersiveEntity = try await Entity(named: "Statue_of_liberty", in: realityKitContentBundle)
                
                let immersiveEntity2 = try await Entity(named: "BP_1660-A-01_Jan_Martyn", in: realityKitContentBundle)
                
                let immersiveEntity3 = try await Entity(named: "BP_1660-A-03_Marten_Cregier", in: realityKitContentBundle)
                
                Statue_of_libertyEntity.addChild(immersiveEntity)
                
                Jan_Martyn.addChild(immersiveEntity2)
                
                Marten_Cregier.addChild(immersiveEntity3)
                
                content.add(Statue_of_libertyEntity)
                content.add(Jan_Martyn)
                content.add(Marten_Cregier)
            }
            catch {
                print("Error in RealityView's make: \(error)")
            }
        } update: { content in
            for entity in content.entities {
                let simd = SIMD3(x: Float(appData.objectScale), y: Float(appData.objectScale), z: Float(appData.objectScale))
                
                entity.scale = simd
                
                if entity.name == "Statue_of_libertyEntity" {
                    entity.position.z = Float((appData.objectDistance))
                }
                else if entity.name == "Jan_Martyn" {
                    entity.position.z = Float(-(appData.objectDistance))
                }
                else if entity.name == "Marten_Cregier" {
                    entity.position.x = Float((appData.objectDistance))
                }
            }
        }
    }
}

#Preview {
    ImmersiveView(appData: AppData())
        .previewLayout(.sizeThatFits)
}
