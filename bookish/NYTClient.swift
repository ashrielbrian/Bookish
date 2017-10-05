//
//  NYTClient.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation

// Class to make network requests to The New York Times

class NYTClient: NSObject {
    
    // Instantiating the NYTClient class
    class func sharedInstance() -> NYTClient {
        struct Singleton {
            static var instance = NYTClient()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
    }
    
    let session = URLSession.shared
    
    func bookReviewSearch (title: String, completionHandlerForBookReviewSearch: @escaping (_ success: Bool, _ error: NSError?, _ bookReviewResults: [[String: AnyObject]]?) -> Void) {
        
        let queries = [QueryKeys.key: UniqueIdKeys.apiKey, QueryKeys.title: title]
        let searchUrl = urlNYTFromParameters(withQuery: queries)
        
        var request = URLRequest(url: searchUrl)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            print(searchUrl.absoluteString)
            func sendError(_ errorString: String) {
                let userInfo = [NSLocalizedDescriptionKey: errorString]
                completionHandlerForBookReviewSearch(false, NSError(domain: "bookReviewSearch", code: 1, userInfo: userInfo), nil)
            }
            
            guard error == nil else {
                sendError("Error making connection request to The New York Times using \(searchUrl)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200, statusCode <= 299 else {
                sendError("Status code did not return 2xx")
                return
            }
            
            if let data = data {
                self.convertDataToJSONWithCompletionHandler(data: data, completionHandlerForConvertData: {
                    (results, error) in
                    
                    guard error == nil else {
                        sendError("Error parsing JSON in \(data)")
                        return
                    }
                    
                    if let results = results {
                        guard let reviews = results[JSONResponseKeys.results] as! [[String: AnyObject]]? else {
                            sendError("Could not find key '\(JSONResponseKeys.results)' in \(results)")
                            return
                        }
                        completionHandlerForBookReviewSearch(true, nil, reviews)
                        
                    } else {
                        sendError("No JSON was parsed from \(data)")
                    }
                })
            }
        }
        task.resume()
    }
    
    
    private func convertDataToJSONWithCompletionHandler(data: Data, completionHandlerForConvertData: (_ results: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedJSON: AnyObject? = nil
        
        do {
            parsedJSON = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey: "Could not parse JSON with \(data)"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataToJSONWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedJSON, nil)
    }
    
    private func urlNYTFromParameters(withPathExtension: String? = nil, withQuery: [String: String]? = nil) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.APIScheme
        components.host = Constants.APIHost
        components.path = Constants.APIPath
        
        if let withQuery = withQuery {
            var queryItems = [URLQueryItem]()
            
            for (key, value) in withQuery {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
            
            components.queryItems = queryItems
        }
        
        return components.url!
    }
    
    
}
