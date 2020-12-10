//
//  PostError.swift
//  Continuum
//
//  Created by Heli Bavishi on 12/8/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import Foundation

enum PostError: LocalizedError {
    
    case noPost
    
    var localizedDescription: String {
        switch self {
        case .noPost:
            return "The post was not found"
        }
    }
}
