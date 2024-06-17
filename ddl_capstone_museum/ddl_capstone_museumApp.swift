//
//  ddl_capstone_museumApp.swift
//  ddl_capstone_museum
//
//  Created by Chantel Dean on 6/14/24.
//

import SwiftUI

@main
struct ddl_capstone_museumApp: App {
    var body: some Scene {
        WindowGroup(id: "Content") {
            ContentView()
        }
        
       WindowGroup(id: "DetailView", for: String.self) { value in
           DetailView(title: value.wrappedValue!)
        }


       ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }.immersionStyle(selection: .constant(.mixed), in: .mixed)
   }
}
