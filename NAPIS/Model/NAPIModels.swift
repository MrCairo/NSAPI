//
//  NAPITitle.swift
//  NAPIS
//
//  Created by Mitch Fisher on 2/25/21.
//  Copyright © 2021 Committed Code. All rights reserved.
//

import SwiftUI

struct NAPITitle: Codable, Equatable, Identifiable {
    let title: String
    let description: String
    var id = UUID()
}


struct APODData {
    let title: String
    let description: String
    let url: URL
    let copyright: String?
    let mediaType: String
    
    enum Keys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
        case mediaType = "media_type"
    }
    
    var isImage: Bool {
        return mediaType == "image"
    }
    
    var isVideo: Bool {
        return mediaType == "video"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: Keys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: Keys.title)
        self.description = try valueContainer.decode(String.self, forKey: Keys.description)
        self.url = try valueContainer.decode(URL.self, forKey: Keys.url)
        self.copyright = try? valueContainer.decode(String.self, forKey: Keys.copyright)
        self.mediaType = try valueContainer.decode(String.self, forKey: Keys.mediaType)
    }
}


#if DEBUG
extension NAPITitle {
    static let mockedData: [NAPITitle] = [
        NAPITitle(title: "Hobbit", description: "One of the first works of J.R.R Tolkien."),
        NAPITitle(title: "About", description: "Something about this app")
    ]
}
#endif
