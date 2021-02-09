//
//  NAPIListingCell.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 2/9/21.
//  Copyright © 2021 Committed Code. All rights reserved.
//

import SwiftUI
import UIKit

struct NAPICell: View {
//    let image: Image
    let title: String
    let fullName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title)
                Text(fullName)
                    .font(.headline)
            }
            Spacer()
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}

//private struct NAPICell2: UIViewRepresentable {
//
//    func makeUIView(context: Context) -> UITableViewCell {
//    }
//
//    func updateUIView(_ uiView: UITableViewCell, context: Context) {
//    }
//}

struct NAPITableViewCell2: View {
    var body: some View {
        NAPICell(title: "Title", fullName: "Full Name")
    }
}

struct NAPICell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NAPICell(title: "Title", fullName: "Full Name")
        }
    }
}
