//
//  GoodReadsClient.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import Foundation

// MARK: - GoodReads Client Network Request
class GoodReadsClient: NSObject {
    
    override init () {
        super.init()
    }
    
    // MARK: Properties
    var latestBookReviews = [GoodReadsBookReview]()
    var currentElement = ""
    var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentUser = "" {
        didSet {
            currentUser = currentUser.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentReviewUrl = "" {
        didSet {
            currentReviewUrl = currentReviewUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    var currentReviewBody = "" {
        didSet {
            currentReviewBody = currentReviewBody.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    var currentImageUrl = "" {
        didSet {
            currentImageUrl = currentImageUrl.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    let session = URLSession.shared

    var parserCompletionHandler: ((_ success: Bool, _ error: Error?, _ booksReview: [GoodReadsBookReview]?) -> Void)?

    // MARK: Delegate Properties
    var insideUserTag = false
    var insideBookTag = false

    // MARK: Network Request Functions
    
    func parse(completionHandlerForParse: @escaping (_ success: Bool, _ error: Error?, _ booksReview: [GoodReadsBookReview]?) -> Void) {
        
        self.parserCompletionHandler = completionHandlerForParse
        
        let queries = [ParameterKeys.key: UniqueIdKeys.apiKey]
        let url = goodReadsUrlFromParameters(queries)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            func sendError(_ errorString: String) {
                let userInfo = [NSLocalizedDescriptionKey: errorString]
                completionHandlerForParse(false, NSError(domain: "parse", code: 1, userInfo: userInfo), nil)
            }
            
            guard error == nil else {
                sendError("Error making a connection to GoodReads server using \(url)")
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200, statusCode <= 299 else {
                sendError("Status code did not return 2xx")
                return
            }
            
            guard let data = data else {
                sendError("No data was returned")
                return
            }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
        }
        task.resume()
        
    }
    
    func goodReadsUrlFromParameters(_ withQuery: [String: String]? = nil) -> URL {
        
        var components = URLComponents()
        components.host = Constants.APIHost
        components.scheme = Constants.APIScheme
        components.path = Constants.APIPath
        
        if let queries = withQuery {
            
            var queryItems = [URLQueryItem]()
            for (key, value) in queries {
                let queryItem = URLQueryItem(name: key, value: value)
                queryItems.append(queryItem)
            }
            components.queryItems = queryItems
        }
        
        return components.url!
    }
}

// MARK: - GoodReads XML Parser Delegate Functions

extension GoodReadsClient: XMLParserDelegate {
    

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if elementName == XMLResponseElements.review {
            currentUser = ""
            currentTitle = ""
            currentReviewBody = ""
            currentReviewUrl = ""
            currentImageUrl = ""
        } else if elementName == XMLResponseElements.user {
            insideUserTag = true
            currentElement = XMLResponseElements.user
        } else if elementName == XMLResponseElements.book {
            insideBookTag = true
            currentElement = XMLResponseElements.book
        }
        
    }
    
    // There are repeat tags within the XML doc. To avoid reading the wrong tags belonging to the wrong category, insideUserTag and insideBookTag identifies if the parser is currently within the correct tag
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if insideUserTag {
            switch currentElement {
                case XMLResponseElements.username:
                    currentUser += string
                
                default:
                    break
            }
        }
        
        if insideBookTag {
            switch currentElement {
                case XMLResponseElements.title:
                    currentTitle += string
                
                case XMLResponseElements.bookImageUrl:
                    currentImageUrl += string
                
                default:
                    break
            }
        }
        
        switch currentElement {
            case XMLResponseElements.reviewBody:
                currentReviewBody += string
            case XMLResponseElements.url:
                currentReviewUrl += string
            default:
                break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        switch elementName {
            case XMLResponseElements.user:
                insideUserTag = false
            
            case XMLResponseElements.book:
                insideBookTag = false
            
            case XMLResponseElements.authors:
                insideBookTag = false
            
            case XMLResponseElements.review:
                let bookReview = GoodReadsBookReview(title: currentTitle, imageUrl: currentImageUrl, reviewBody: currentReviewBody, reviewUrl: currentReviewUrl, username: currentUser)
                latestBookReviews.append(bookReview)
            
            default:
                break
        }
    }
    
    // Once the parser has finished going through the XML doc, pass success as true to the completionHandler
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(true, nil, latestBookReviews)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        parserCompletionHandler?(false, parseError as NSError, nil)
    }
    
}
