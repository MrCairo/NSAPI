//
//  NAPIListingView.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 2/9/21.
//  Copyright © 2021 Committed Code. All rights reserved.
//

import SwiftUI
import Foundation

struct NAPIListingView: View {
    
    var viewModel: NAPIMenuViewModel = NAPIMenuViewModel()
    var body: some View {
        
        List(viewModel.entries) { entry in
            entry
        }.onAppear {
            self.viewModel.loadMenu()
        }
    }
}


extension NAPIListingView {
    class NAPIMenuViewModel {
        private(set) var entries: [NAPIMenuCell] = []
        
        func loadMenu() {
            self.entries = [
                NAPIMenuCell(info: NAPITitle(title: "About",
                                             description: "About NAPIS")),
                NAPIMenuCell(info: NAPITitle(title: "APOD",
                                             description: "Astronomy Picture of the Day"))
            ]
        }
        #if DEBUG
        static func mockModel() -> NAPIMenuViewModel {
            let model = NAPIListingView.NAPIMenuViewModel()
            model.entries = [
                NAPIMenuCell(info: NAPITitle(title: "Title 1",
                                             description: "About Title 1")),
                NAPIMenuCell(info: NAPITitle(title: "Title 2",
                                             description: "About Title 2"))
            ]
            return model
        }
        #endif
    }
}

#if DEBUG
struct NAPIListingView_Previews: PreviewProvider {
    static var previews: some View {
        NAPIListingView(viewModel: NAPIListingView.NAPIMenuViewModel()
        )
    }
}
#endif
