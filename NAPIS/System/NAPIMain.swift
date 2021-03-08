//
//  NAPIMain.swift
//  NAPIS
//
//  Created by Mitch Fisher on 2/25/21.
//  Copyright © 2021 Committed Code. All rights reserved.
//

import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            Text("Hello World!")
        }
    }
}

struct NAPIMain: View {
    var body: some View {
        NAPIListingView()
    }
}

struct NAPIMain_Previews: PreviewProvider {
    static var previews: some View {
        NAPIMain()
    }
}
