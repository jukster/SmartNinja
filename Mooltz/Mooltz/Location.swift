//
//  Classes.swift
//  Mooltz
//
//  Created by Marko Jukic on 21/10/15.
//  Copyright © 2015 Marko Jukic. All rights reserved.
//

import Foundation
import UIKit

/*
enum Priority: Int, CustomStringConvertible {
    case Normal, High
    
    var description : String {

        switch self {
        case .Normal: return "Normal";
        case .High: return "High";
        }
    }
}
*/

enum Location: Int, CustomStringConvertible {
    
    case Here, There
    
    var description: String {
        
        switch self {
        case .Here: return "Here";
        case .There: return "There";
        }
    }
}

let mojFont = UIFont(name: "Avenir Next", size: 16.0)

let mojFontBold = UIFont(name: "AvenirNext-Bold", size: 16.0)