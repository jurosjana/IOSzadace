//
//  ServerResponse.swift
//  IOSQuizz
//
//  Created by Jana on 06/06/2020.
//  Copyright © 2020 Jana. All rights reserved.
//

import Foundation

enum ServerResponse : Int {
    
    case OK = 200
    case UNAUTHORIZED = 401
    case FORBIDDEN = 403
    case NOT_FOUND = 404
    case BAD_REQUEST = 400
    
    
    var name: String {
        switch self {
            case .OK:
                return  "200 Ok"
                
            case .UNAUTHORIZED:
                return "401 Unauthorized"
        
            case .FORBIDDEN:
                return "403 Forbidden"
            
            case .NOT_FOUND:
                return "404 Not found"
            
            case .BAD_REQUEST:
                return "400 Bad request"
        }
    }

    var message: String {
        switch self {
            case .OK:
                return  "200 Ok - Success"
                
            case .UNAUTHORIZED:
                return "401 Unauthorized - token is invalid"
        
            case .FORBIDDEN:
                return "403 Forbidden - token and id don't match"
            
            case .NOT_FOUND:
                return "404 Not found - quiz(id) not found"
            
            case .BAD_REQUEST:
                return "400 Bad request - wrong type for time (decimal) or no_of_correct (integer)"
        }
    
    }

}
