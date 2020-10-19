//
//  Model.swift
//  LearnWithTranslation
//
//  Created by MAC on 19.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import Foundation

struct Base: Decodable {
    var Status: Bool
    var Message:String
    var Entity: [Entity]
    
}

struct Entity: Decodable {
    var Id: Int
    var AppKey:String?
    var Title:String?
    var Icon:String?
    var ShortDescription:String?
    var Description:String?
    var Categories: String?
    
    
}

