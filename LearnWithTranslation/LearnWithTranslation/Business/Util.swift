//
//  Util.swift
//  LearnWithTranslation
//
//  Created by MAC on 20.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import Foundation

var baseUrl = "http://api.bankomaclar.com/api/v1"

extension Array
{
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
