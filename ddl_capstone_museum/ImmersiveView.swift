//
//  ImmersiveView.swift
//  ddl_capstone_museum
//
//  Created by Chantel Dean on 6/14/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

//constructor for the immersiveview.
struct ImmersiveView: View {
    //declare initial states for environment variables, gesture, pillars, and the two cameras.
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.openWindow) var openWindow
    
    //Variables for this project.
    @State var lastGestureValue = CGFloat(0)
    @State var CubeGuitar = Entity()
    @State var CylinderErhu = Entity()
    @State var CylinderErhu_1 = Entity()
    @State var CapsuleInstrument = Entity()
    
    
    //Body variable
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let scene = try? await Entity(named: "Immersive", in: realityKitContentBundle) {
                content.add(scene)
                
                /* Occluded floor  - won't be visible in the scene.  Keeps objects from slipping through the floor.*/
                let floor = ModelEntity(mesh: .generatePlane(width: 10000, depth: 10000	), materials: [OcclusionMaterial()])
                floor.generateCollisionShapes(recursive: false)
                floor.components[PhysicsBodyComponent.self] = .init(
                    massProperties: .default,
                    mode: .static
                )
                content.add(floor)
                
                //Use async and await for each scultural item that appears.
                
                async let CubeGuitar = Entity(named: "CubeGuitar", in: realityKitContentBundle)
                async let CylinderErhu = Entity(named: "CylinderErhu", in: realityKitContentBundle)
                async let CylinderErhu_1 = Entity(named: "CylinderErhu_1", in: realityKitContentBundle)
                async let CapsuleInstrument = Entity(named: "CapsuleInstrument", in: realityKitContentBundle)
                
                if let CubeGuitar = try?await CubeGuitar,
                   let CylinderErhu = try?await CylinderErhu,
                   let CylinderErhu_1 = try?await CylinderErhu_1,
                   let CapsuleInstrument = try?await CapsuleInstrument{
                    self.CubeGuitar = CubeGuitar
                    content.add(CubeGuitar);
                    content.add(CylinderErhu);
                    content.add(CylinderErhu_1);
                    content.add(CapsuleInstrument)
                    
                    CubeGuitar.position=[15, 0, 100]
                    CylinderErhu.position=[10, 0, 100]
                    CylinderErhu_1.position=[5, 0, 100]
                    CapsuleInstrument.position=[0, 0, 100]
                    
                    #Preview {
                        ImmersiveView()
                            .previewLayout(.sizeThatFits)
                    }
                }
            }
        }
    }
}
