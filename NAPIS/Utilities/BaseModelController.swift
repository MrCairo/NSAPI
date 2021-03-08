//
//  BaseModelController.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 1/2/19.
//  Copyright © 2019 Committed Code. All rights reserved.
//

import Foundation

class ModelController<ModelType:Codable> {
    
    public let manager:MediaInfoManager
    
    init() {
        manager = MediaInfoManager()
    }
    
    public func fetchMedia(completion: @escaping (ModelType?) -> Void) {
        manager.NAPIWebService(endpoint: "planetary/apod",
                               queryParms: []) { (data) in
                                let results:ModelType? = self.decoder(data)
                                completion(results)
        }
    }
    
    
    public func fetchData(fromUrl url: URL, completion: @escaping (Data?) -> Void) {
        manager.fetchUrlData(with: url) { (data) in
            completion(data)
        }
    }
    
    
    fileprivate func decoder<T:Codable>(_ data: Data?) -> T? {
        var info:T? = nil
        if let data = data {
            let decoder = JSONDecoder()
            info = try? decoder.decode(T.self, from: data)
        }
        
        return info
    }
    
}
