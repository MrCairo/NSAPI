//
//  NAPIListingView.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 2/9/21.
//  Copyright © 2021 Committed Code. All rights reserved.
//

import SwiftUI

struct NAPIListingView: View {
    var body: some View {
        List {
            NAPICell(title: "Title", fullName: "Full Name")
            NAPICell(title: "Title", fullName: "Full Name")
            NAPICell(title: "Title", fullName: "Full Name")
            NAPICell(title: "Title", fullName: "Full Name")
            NAPICell(title: "Title", fullName: "Full Name")
            NAPICell(title: "Title", fullName: "Full Name")
            NAPICell(title: "Title", fullName: "Full Name")
        }
    }
}

struct NAPIListingView_Previews: PreviewProvider {
    static var previews: some View {
        NAPIListingView()
    }
}
