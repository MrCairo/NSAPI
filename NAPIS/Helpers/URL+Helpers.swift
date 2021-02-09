//
//  URL+Helpers.swift
//  SpacePhoto
//
//  Created by Peter Minarik on 01.07.18.
//  Copyright © 2018 Peter Minarik. All rights reserved.
//

import Foundation

extension URL {
  
  func withQueries(_ queries: [URLQueryItem]) -> URL? {
    var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
    components?.queryItems = queries //queries.compactMap({ URLQueryItem(name: $0.0, value: $0.1) })
    return components?.url
  }
}
