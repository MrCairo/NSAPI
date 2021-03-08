//
//  JSONHandler.swift
//  NAPIS
//
//  Created by Mitch Fisher on 2/26/21.
//  Copyright © 2021 Committed Code. All rights reserved.
//

import Foundation

class NAPIMenuItem: Codable {
    let title: String
    let desc: String
}

class NAPIMainMenu: Codable {
    let mainMenu: [NAPIMenuItem]
}

class JSONHandler {
    
    class func loadMenuFrom(filename: String) -> NAPIMainMenu? {
        guard let path = Bundle.main.path(forResource: filename, ofType: "json") else { return nil }
        let url = URL(fileURLWithPath: path)
        if let json = try? Data(contentsOf: url) {
            return try? JSONDecoder().decode(NAPIMainMenu.self, from: json)
        }
        
        return nil
    }
}
