//
//  NYTBookReviewModel.swift
//  Bookish
//
//  Created by Ashriel Brian Tang on 20/09/2017.
//  Copyright © 2017 Udacity. All rights reserved.
//

import Foundation

struct NYTBookReview {
    
    let bookAuthor: String?
    let bookTitle: String?
    let reviewAuthor: String?
    let reviewUrl: String?
    let summary: String?
    
    init(dictionary: [String: AnyObject]) {
        
        bookAuthor = dictionary[NYTClient.JSONResponseKeys.bookAuthor] as? String
        bookTitle = dictionary[NYTClient.JSONResponseKeys.bookTitle] as? String
        reviewAuthor = dictionary[NYTClient.JSONResponseKeys.reviewAuthor] as? String
        reviewUrl = dictionary[NYTClient.JSONResponseKeys.reviewUrl] as? String
        summary = dictionary[NYTClient.JSONResponseKeys.bookSummary] as? String
    }
    
    static func bookReviewsFromResults(results: [[String: AnyObject]]) -> [NYTBookReview] {
        
        var bookReviews = [NYTBookReview]()
        
        for eachResult in results {
            bookReviews.append(NYTBookReview(dictionary: eachResult))
        }
        
        return bookReviews
    }
    
}
