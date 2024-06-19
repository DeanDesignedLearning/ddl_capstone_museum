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
    
    @State var lastGestureValue = CGFloat(0)
    @State var stand = Entity()
    @State var CubeGuitar = Entity()
    @State var CylinderErhu = Entity()
    @State var CylinderErhu_1 = Entity()
    @State var CapsuleInstrument = Entity()
    
    
    
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
                    
                    /* Create the camera table(stand)
                     let stand = ModelEntity(
                     mesh: .generateBox(width: 1.0, height: 1.0, depth: 1.0),
                     materials: [SimpleMaterial(color: .black, isMetallic: false)])
                     stand.position.y = 0.0 // 1 meter (m) above the floor
                     stand.position.z = -1.5 // 1.5m in front of the user
                     stand.position.x = 0.5 // 0.5m right of center
                     stand.generateCollisionShapes(recursive: false)
                     // Enable interactions on the entity.
                     stand.components.set(InputTargetComponent())
                     stand.components.set(CollisionComponent(shapes: [.generateSphere(radius: 0.1)]))
                     // gravity to PhysicsBody
                     stand.components[PhysicsBodyComponent.self] = .init(
                     PhysicsBodyComponent(
                     // mass in kilograms
                     massProperties: .init(mass: 5.0),
                     material: .generate(
                     staticFriction: 0.0,
                     dynamicFriction: 0.0,
                     restitution: 0.5
                     ),
                     mode: .dynamic
                     )
                     )
                     
                     stand.physicsMotion = PhysicsMotionComponent()
                     // add gravity
                     stand.components[PhysicsBodyComponent.self]?.isAffectedByGravity = true
                     // visualizationmode
                     let visDebug = ModelDebugOptionsComponent(visualizationMode: .textureCoordinates)
                     stand.modelDebugOptions = visDebug
                     content.add(stand)
                     // Add the initial RealityKit content
                     */}
                
                /*
                
                //Add the cameras
                async let Speed_Graphic_Camera = Entity(named: "Speed_Graphic_Camera", in: realityKitContentBundle)
                async let Zenit_6_camera = Entity(named: "Zenit_6_camera", in: realityKitContentBundle)
                
                
                if let Speed_Graphic_Camera = try?await Speed_Graphic_Camera,
                   let Zenit_6_camera = try?await Zenit_6_camera{
                    self.Speed_Graphic_Camera = Speed_Graphic_Camera
                    content.add(Speed_Graphic_Camera)
                    content.add(Zenit_6_camera)
                    
                    Speed_Graphic_Camera.position=[5, 20, 100]
                    Zenit_6_camera.position=[-5, 20, 100]
                }
                
                
                
                /*// Add an ImageBasedLight for the immersive content
                 guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                 let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                 
                 
                 Speed_Graphic_Camera.components.set(iblComponent)
                 Speed_Graphic_Camera.components.set(ImageBasedLightReceiverComponent(imageBasedLight: Speed_Graphic_Camera))
                 
                 Zenit_6_camera.components.set(iblComponent)
                 Zenit_6_camera.components.set(ImageBasedLightReceiverComponent(imageBasedLight: Zenit_6_camera))*/
                
                
                /*var tapGesture: some Gesture {
                 TapGesture()
                 .targetedToAnyEntity()
                 .onChanged { value in
                 let message = "beginning tap"
                 print(message)
                 }
                 .onEnded { value in
                 let message = "entity tapped"
                 print(message)
                 self.openWindow(id: "DetailView", value: value.entity.name)
                 }
                 }
                 
                 var dragGesture: some Gesture {
                 DragGesture()
                 .targetedToAnyEntity()
                 .onChanged { value in
                 value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                 value.entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
                 }
                 .onEnded { value in
                 value.entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
                 }
                 
                 Speed_Graphic_Camera.wrappedValue.gesture(dragGesture)
                 Speed_Graphic_Camera.wrappedValue.gesture(tapGesture)
                 Zenit_6_camera.wrappedValue.gesture(dragGesture)
                 Zenit_6_camera.wrappedValue.gesture(tapGesture)
                 }
                 */
                //Make 3D objects draggable
                
                
                
                
                
                
                /*
                 
                 
                 }
                 async let Speed_Graphic_Camera = Entity(named: "Speed_Graphic_Camera", in: realityKitContentBundle)
                 async let Zenit_6_camera = Entity(named: "Zenit_6_camera", in: realityKitContentBundle)
                 
                 
                 if let Speed_Graphic_Camera = try?await Speed_Graphic_Camera,
                 let Zenit_6_camera = try?await Zenit_6_camera
                 {
                 self.Speed_Graphic_Camera = Speed_Graphic_Camera
                 content.add(Speed_Graphic_Camera)
                 content.add(Zenit_6_camera)
                 
                 
                 Speed_Graphic_Camera.position=[1, 1, -5]
                 Zenit_6_camera.position=[-1, 1, -5]
                 
                 
                 
                 // Add an ImageBasedLight for the immersive content
                 guard let resource = try? await EnvironmentResource(named: "ImageBasedLight") else { return }
                 let iblComponent = ImageBasedLightComponent(source: .single(resource), intensityExponent: 0.25)
                 
                 
                 Speed_Graphic_Camera.components.set(iblComponent)
                 Speed_Graphic_Camera.components.set(ImageBasedLightReceiverComponent(imageBasedLight: Speed_Graphic_Camera))
                 
                 Zenit_6_camera.components.set(iblComponent)
                 Zenit_6_camera.components.set(ImageBasedLightReceiverComponent(imageBasedLight: Zenit_6_camera))
                 }
                 }
                 }
                 //drag gesture.
                 .gesture(dragGesture)
                 }
                 var dragGesture: some Gesture {
                 DragGesture()
                 .targetedToAnyEntity()
                 .onChanged { value in
                 value.entity.position = value.convert(value.location3D, from: .local, to: value.entity.parent!)
                 value.entity.components[PhysicsBodyComponent.self]?.mode = .kinematic
                 }
                 .onEnded { value in
                 value.entity.components[PhysicsBodyComponent.self]?.mode = .dynamic
                 }
                 }
                 
                 //immersiveview
                 // #Preview {
                 //   ImmersiveView()
                 //       .previewLayout(.sizeThatFits)
                 
                 }
                 // }
                 
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
                  .onAppear {
                  dismissWindow(id: "Content")
                  }
                  }
                  }
                  */*/*/
                
                #Preview {
                    ImmersiveView()
                        .previewLayout(.sizeThatFits)
                }
            }
        }
    }
}
