//
//  Constants.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import Foundation

extension NYTClient {
    
    struct UniqueIdKeys {
        static let apiKey = "8c12b18b9d44429c98cb0cc2aec97521"
    }
    
    struct Constants {
        static let APIScheme = "https"
        static let APIHost = "api.nytimes.com"
        static let APIPath = "/svc/books/v3/reviews.json"
    }
    
    struct QueryKeys {
        static let key = "api-key"
        static let title = "title"
    }
    
    struct JSONResponseKeys {
        static let status = "status"
        static let results = "results"
        static let reviewUrl = "url"
        static let bookTitle = "book_title"
        static let bookAuthor = "book_author"
        static let bookSummary = "summary"
        static let reviewAuthor = "byline"
    }
    
    
}
