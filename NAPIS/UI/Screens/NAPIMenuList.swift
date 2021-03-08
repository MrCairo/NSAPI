//
//  NAPIMenuList.swift
//  NAPIS
//
//  Created by Mitch Fisher on 2/25/21.
//  Copyright © 2021 Committed Code. All rights reserved.
//

import SwiftUI

struct NAPIMenuList: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List(viewModel.entries) { entry in
            NAPIMenuCell(info: entry)
        }
        .onAppear {
            self.viewModel.loadMenu()
        }
    }
}


extension NAPIMenuList {
    
    class ViewModel: ObservableObject {
        @Published private(set) var entries: [NAPITitle] = []
        
        func loadMenu() {
            self.entries = [
                NAPITitle(title: "About", description: "About NAPIS"),
                NAPITitle(title: "APOD", description: "Astronomy Picture of the Day")
            ]
        }

        #if DEBUG
        static func mockModel() -> ViewModel {
            let model = NAPIMenuList.ViewModel()
            model.entries = [
                NAPITitle(title: "Title 1",
                          description: "About Title 1"),
                NAPITitle(title: "Title 2",
                          description: "About Title 2")
            ]
            return model
        }
        #endif
    }
}

#if DEBUG
struct NAPIMenuList_Previews: PreviewProvider {
    
    static var previews: some View {
        NAPIMenuList(viewModel: NAPIMenuList.ViewModel.mockModel())
    }
}
#endif


