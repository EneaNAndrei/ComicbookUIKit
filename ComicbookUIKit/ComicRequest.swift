//
//  ComicRequest.swift
//  ComicbookUIKit
//
//  Created by Andrei Enea on 02.01.2023.
//

import Foundation

struct ComicRequest: BaseRequest {
    typealias Response = Comic
    
    
    var comicbookId: String = ""
    
    var url: String {
        let baseURL = "https://xkcd.com"
        let path = "/info.0.json"
        
        return baseURL + comicbookId + path
    }
    
    var method: HTTPMethod {
        .get
    }
}

