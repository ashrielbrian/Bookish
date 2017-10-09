//
//  GoodReadsConstants.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Ashriel Brian Tang. All rights reserved.
//

import Foundation

extension GoodReadsClient {
    
    struct UniqueIdKeys {
        static let apiKey = "j8aoKasGpsIkeFR5SDvEGg"
    }
    
    struct Constants {
        static let APIScheme = "https"
        static let APIHost = "www.goodreads.com"
        static let APIPath = "/review/recent_reviews.xml"
    }
    
    struct ParameterKeys {
        static let key = "key"
    }
    
    struct XMLResponseElements {
        static let reviews = "reviews"
        static let review = "review"
        static let user = "user"
        static let username = "name"
        static let book = "book"
        static let title = "title"
        static let authors = "authors"
        static let author = "author"
        static let url = "url"
        static let link = "link"
        static let reviewBody = "body"
        static let bookImageUrl = "small_image_url"
    }
    
}
