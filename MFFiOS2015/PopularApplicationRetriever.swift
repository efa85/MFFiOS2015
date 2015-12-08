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

let httpErrorDomain = "HTTPErrorDomain"

private let endPointURLString = "https://itunes.apple.com/search"

class PopularApplicationRetriever {
    
    private let urlSession: NSURLSession = NSURLSession.sharedSession()
    private let endPointURL: NSURL = NSURL(string: endPointURLString)!
    
    func retrievePopularApplicationsWithCountryCode(countryCode: String, completion: (PopularApplicationRetrieverResult) -> Void) {
        // Sample URL: https://itunes.apple.com/search?term=*&country=cz&entity=software
        let applicationsURL = applicationsURLWithCountryCode(countryCode)
        let task = urlSession.dataTaskWithURL(applicationsURL) { [weak self] (data, response, error) -> Void in
            self?.handleData(data, response: response, error: error, completion: completion)
        }
        task.resume()
    }
    
    // MARK: Private
    
    private func handleData(data: NSData?, response: NSURLResponse?, error: NSError?, completion: (PopularApplicationRetrieverResult) -> Void) {
        if let error = error {
            completion(.Failure(error: error))
            return
        }
        
        let httpResponse = response as! NSHTTPURLResponse
        if httpResponse.statusCode != 200 {
            let error = serverErrorWithResponse(httpResponse)
            completion(.Failure(error: error))
            return
        }
        
        do {
            let applications = try parseApplicationsWithData(data!)
            completion(.Success(applications: applications))
        } catch let error as NSError {
            completion(.Failure(error: error))
        }
    }
    
    private func serverErrorWithResponse(response: NSHTTPURLResponse) -> NSError {
        return NSError(domain: "HTTPErrorDomain", code: response.statusCode, userInfo: nil)
    }
    
    private func applicationsURLWithCountryCode(countryCode: String) -> NSURL {
        let urlComponents = NSURLComponents(URL: endPointURL, resolvingAgainstBaseURL: false)!
        urlComponents.query = "term=*&country=\(countryCode)&entity=software"
        
        return urlComponents.URL!
    }
    
}

// MARK: Application parsing

private func parseApplicationsWithData(data: NSData) throws -> [Application] {
    // Parsing JSON in Swift is either ugly or unsafe, a good alternative is to use https://github.com/SwiftyJSON/SwiftyJSON
    let responseRepresentation = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
    let responseDictionary = responseRepresentation as! NSDictionary
    let appDictionaries = responseDictionary["results"] as! [NSDictionary]
    return appDictionaries.map {
        applicationWithDictionaryRepresentation($0)
    }
}

private  func applicationWithDictionaryRepresentation(dictionary: NSDictionary) -> Application {
    let name = dictionary["trackName"] as! String
    let developer = dictionary["artistName"] as! String
    let price = dictionary["formattedPrice"] as! String
    return Application(name: name, developer: developer, price: price)
}
