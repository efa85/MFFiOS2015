//
//  PopularApplicationRetriever.swift
//  MFFiOS2015
//
//  Created by Fernandez Astigarraga Emilio on 08/12/15.
//  Copyright © 2015 avast. All rights reserved.
//

import Foundation

struct Application {
    let name: String
    let developer: String
    let price: String
}

enum PopularApplicationRetrieverResult {
    case Success(applications: [Application])
    case Failure(error: NSError)
}

class PopularApplicationRetriever {
    
    func retrievePopularApplicationsWithCountryCode(countryCode: String, completion: (PopularApplicationRetrieverResult) -> Void) {
        
    }
    
}
