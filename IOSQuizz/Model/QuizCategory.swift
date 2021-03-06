//
//  QuizCategory.swift
//  IOSQuizz
//


import Foundation
import UIKit


public enum QuizCategory : Int16 {

    
    case SPORTS = 0
    case SCIENCE = 1
    case DEFAULT = 2
    
    var color: UIColor {
        switch self {
        case .SPORTS:
            return #colorLiteral(red: 0.4988093972, green: 0.7685493231, blue: 1, alpha: 1)
            
        case .SCIENCE:
            return #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
        case .DEFAULT:
            return #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 0.2831496147)
        }
    }
        
    var name: String {
        switch self {
            case .SPORTS:
                return  "Sports"
                
            case .SCIENCE:
                return "Science"
        
            case .DEFAULT:
                return "Default"
            }
    }
    
    
}



