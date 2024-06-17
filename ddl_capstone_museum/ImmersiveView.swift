//
//  ImmersiveView.swift
//  ddl_capstone_museum
//
//  Created by Chantel Dean on 6/14/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(\.dismissWindow) var dismissWindow
    @Environment(\.openWindow) var openWindow
    
    @State var lastGestureValue = CGFloat(0)
    @State var pillars = Entity()
    @State var Speed_Graphic_Camera = Entity()
    @State var Zenit_6_camera = Entity()
    
    var body: some View {
        RealityView { content in
            
            // Add the initial RealityKit content
            async let pillars = Entity(named: "pillars", in: realityKitContentBundle)
            async let Speed_Graphic_Camera = Entity(named: "Speed_Graphic_Camera", in: realityKitContentBundle)
            async let Zenit_6_camera = Entity(named: "Zenit_6_camera", in: realityKitContentBundle)
            // async let Stereoscopic_camera_by_Heinrich_Ernemann = Entity(named: "Stereoscopic_camera_by_Heinrich_Ernemann", in: realityKitContentBundle)
            
            if let pillars = try?await pillars,
               let Speed_Graphic_Camera = try?await Speed_Graphic_Camera,
               let Zenit_6_camera = try?await Zenit_6_camera
            //let Stereoscopic_camera_by_Heinrich_Ernemann = try?await Stereoscopic_camera_by_Heinrich_Ernemann
            
            {
                self.pillars = pillars
                content.add(pillars)
                content.add(Speed_Graphic_Camera)
                content.add(Zenit_6_camera)
                //content.add(Stereoscopic_camera_by_Heinrich_Ernemann)
                
    
                
                pillars.position=[-1, 0, -5]
                Speed_Graphic_Camera.position=[1, 1, -5]
                Zenit_6_camera.position=[-1, 1, -5]
                //Stereoscopic_camera_by_Heinrich_Ernemann.position=[0, 2, 0]
                //Stereoscopic_camera_by_Heinrich_Ernemann.scaleeffect=[-0.25]
                
                
                
                // Add an ImageBasedLight for the immersive content
                guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                
                pillars.components.set(iblComponent)
                pillars.components.set(ImageBasedLightReceiverComponent(imageBasedLight: pillars))
                
                Speed_Graphic_Camera.components.set(iblComponent)
                Speed_Graphic_Camera.components.set(ImageBasedLightReceiverComponent(imageBasedLight: Speed_Graphic_Camera))
                
                Zenit_6_camera.components.set(iblComponent)
                Zenit_6_camera.components.set(ImageBasedLightReceiverComponent(imageBasedLight: Zenit_6_camera))
                
                //Stereoscopic_camera_by_Heinrich_Ernemann.components.set(iblComponent)
                //Stereoscopic_camera_by_Heinrich_Ernemann.components.set(ImageBasedLightReceiverComponent(imageBasedLight: Stereoscopic_camera_by_Heinrich_Ernemann))
                
            }
        }
            
 //       .gesture(TapGesture()
 //           .targetedToEntity(Entity:Zenit_6_camera)
//        .onEnded { value in
 //           print("entity tapped")
 //           self.openWindow(id: "DetailView", value: value.entity.name)
//        }
//    )
        
       
        
        /* .gesture(DragGesture()
         .targetedToAnyEntity()
         .onChanged { value in
         let entity = value.entity
         print("entity name \(entity.name)")
         if entity.name.contains("Speed_Graphic_Camera") {
         let timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
         
         let orientation = Rotation3D(entity.orientation(relativeTo: nil))
         let newOrientation: Rotation3D
         
         if (value.location.x >= lastGestureValue) {
         newOrientation = orientation.rotated(by: .init(angle: .degrees(0.5), axis: .y))
         } else {
         newOrientation = orientation.rotated(by: .init(angle: .degrees(-0.5), axis: .y))
         }
         entity.setOrientation(.init(newOrientation), relativeTo: nil)
         lastGestureValue = value.location.x
         }
         timer.fire()
         } else if entity.name.contains("Zenit_6_camera") {
         Speed_Graphic_Camera.addChild(entity)
         var transform = entity.transform
         transform.translation = [0, 0, 0]
         // define an orbit animation
         
         let animationDefinition = OrbitAnimation(duration: 5, axis: [0, 1, 0], startTransform: transform, bindTarget: .transform, repeatMode: .repeat)
         let animationResouurce = try! AnimationResource.generate(with: animationDefinition)
         entity.playAnimation(animationResouurce)
         }
         }
         )
         */
        
        .onAppear {
            dismissWindow(id: "Content")
        }
    }
}
        
        #Preview{
            ImmersiveView()
                .previewLayout(.sizeThatFits)
        }

