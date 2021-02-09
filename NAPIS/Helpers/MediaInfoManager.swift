//
//  MediaInfoController.swift
//  SpacePhoto
//
//  Created by Peter Minarik on 01.07.18.
//  Copyright © 2018 Peter Minarik. All rights reserved.
//

import Foundation

public class MediaInfoManager {
    fileprivate let apiKey = "uRzLWNLN9bEasIUbGkorbGaeJMCLiWAIAVPvV5Bz"
    fileprivate let baseURL = URL(string: "https://api.nasa.gov/")!
    fileprivate var urlSessionDataTask:URLSessionDataTask?

    ///
    /// Performs a query to the NASA API site.
    ///
    /// - parameter endpoint: A String representing the endpoint excluding
    ///             the host. As an example: ```planetary/apod```
    /// - parameter queryParms: An array of URLQueryItem objects. Each item
    ///                         is then added to the GET query.
    /// - parameter decoder: A block accepting an optional Data object. This
    ///                      block is used to decode the resulting JSON from
    ///                      the web service request. The doecod
    ///
    func NAPIWebService(endpoint: String,
                        queryParms parms:[URLQueryItem],
                        decoder: @escaping ((Data?) -> Void)) {
        //
        // Sorta clean the parms by removing an existing "api_key" value and
        // then adding in the one with the correct value.
        var cleaned = parms.filter({ (item) -> Bool in return item.name != "api_key" })
        cleaned.append(URLQueryItem(name: "api_key", value: apiKey))

        let url = baseURL
            .appendingPathComponent(endpoint)
            .withQueries(cleaned)!
        
        urlSessionDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { decoder(nil); return }
            decoder(data)
        }

        urlSessionDataTask?.resume()
    }
    
    
    func cancel() {
        urlSessionDataTask?.cancel()
    }


    func fetchUrlData(with url: URL, completion: @escaping (Data?) -> Void) {
        urlSessionDataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                completion(data)
            } else {
                completion(nil)
            }
        }
        
        urlSessionDataTask?.resume()
    }
}
