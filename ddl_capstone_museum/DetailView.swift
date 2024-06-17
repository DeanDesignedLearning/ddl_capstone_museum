//
//  DetailView.swift
//  ddl_capstone_museum
//
//  Created by Chantel Dean on 6/15/24.
//

import Foundation
import SwiftUI

struct DetailView: View {
    @State var title: String

    @Environment(\.dismissWindow) private var dismissWindow
    var body: some View {
        VStack(spacing: 50) {
            if title.contains("Speed_Graphic_Camera") {
                Text("Speed Graphic Camera")
                    .font(.extraLargeTitle)
                    .bold()

                Text("The Speed Graphic was a press camera produced by Graflex in Rochester, New York. Although the first Speed Graphic cameras were produced in 1912, production of later versions continued until 1973;[2] with significant improvements occurring in 1947 with the introduction of the Pacemaker Speed Graphic (and Pacemaker Crown Graphic, which was one pound [0.45 kg] lighter and lacked the focal plane shutter).")
                    .font(.title)

            } else if title.contains("Zenit_6_camera") {
                Text("Zenit 6 Camera")
                    .font(.extraLargeTitle)
                    .bold()

                Text("Zenit is a Soviet camera brand manufactured by KMZ in the town of Krasnogorsk near Moscow since 1952 and by BelOMO in Belarus since the 1970s. The Zenit trademark is associated with 35 mm SLR cameras. Among related brands are Zorki (Watchful) for 35 mm rangefinder cameras, Moskva (Moscow) and Iskra (Spark) for medium-format folding cameras and Horizon for panoramic cameras. In the 1960s and 1970s, they were exported by Mashpriborintorg to 74 countries.")
                    .font(.title)
            }


            Button {
                dismissWindow(id: "DetailView")
            } label: {
                Text("dismiss")
            }
        }
    }
}
