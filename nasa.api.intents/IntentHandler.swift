//
//  IntentHandler.swift
//  NAPISIntent
//
//  Created by Mitchell Fisher on 12/28/18.
//  Copyright © 2018 Committed Code. All rights reserved.
//

import Intents
import os

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is APODIntent else {
            fatalError("Unhandled intent: \(intent)")
        }
        
        return APODIntentHandler()
    }
    
}
