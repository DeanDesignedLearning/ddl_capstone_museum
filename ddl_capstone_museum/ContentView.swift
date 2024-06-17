//
//  ContentView.swift
//  ddl_capstone_museum
//
//  Created by Chantel Dean on 6/14/24.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct ContentView: View {

    /*set initial states of the showImmersiveSpace, immersaveSpaceIsShown private values.  Also setting environment values equal to .openImmersiveSpace and .dismissImmmersiveSpace.*/
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    //Setting the body variable.
    var body: some View {

        // Setting up the Vertical Stack
        
        VStack {
            Text("Museum of Art")
            
            Toggle("Show Immersive Space", isOn:$showImmersiveSpace)
                .toggleStyle(.button)
                .padding(50)
               
           
           // Model3D(named: "NewScene", bundle: realityKitContentBundle)
           //.padding(.bottom, 50)
        }
        

        
        .padding()
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

#Preview(windowStyle: .automatic) {
    ContentView()
}
