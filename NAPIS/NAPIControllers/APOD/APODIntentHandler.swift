//
//  APODIntentHandler.swift
//  NAPIS
//
//  Created by Mitchell Fisher on 12/31/18.
//  Copyright © 2018 Committed Code. All rights reserved.
//

import Intents
import os

class APODIntentHandler: NSObject, APODIntentHandling {
    func resolveDate(for intent: APODIntent, with completion: @escaping (INDateComponentsResolutionResult) -> Void) {
        if let str = intent.identifier {
            print(str)
        }
    }

    func confirm(intent: APODIntent, completion: @escaping (APODIntentResponse) -> Void) {
        let controller = ModelController<APODResponseModel>()
        controller.fetchMedia { (model) in
            if let model = model {
                if model.isImage {
                    let activity = NSUserActivity(activityType: "APODIntent")
                    activity.userInfo = ["Hello":"World"]
                    completion(APODIntentResponse(code: .success, userActivity: activity))
                } else {
                    completion(APODIntentResponse(code: .failureNoImage, userActivity: nil))
                }
            }
        }
    }


    func handle(intent: APODIntent, completion: @escaping (APODIntentResponse) -> Void) {
        ModelController<APODResponseModel>().fetchMedia { (model) in
            if let model = model {
                let response = APODIntentResponse.success(photoTitle: model.title)
                completion(response)
            }
        }
    }
}
