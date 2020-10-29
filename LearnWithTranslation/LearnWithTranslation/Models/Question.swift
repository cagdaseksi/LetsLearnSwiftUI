//
//  Question.swift
//  LearnWithTranslation
//
//  Created by MAC on 20.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import Foundation

struct Question: Decodable {
    var Status: Bool
    var Message:String
    var Entity: [QuestionDetails]
}

struct QuestionDetails: Decodable {
    var SubCategoryId: Int
    var QuestionId:Int
    var FromQuestionDetailId: Int
    var ToQuestionDetailId: Int
    var FromTitle:String?
    var ToTitle:String?
    var FromVoice:String?
    var ToVoice:String?
    var FromLanguageId: Int
    var FromLanguageTitle:String?
    var FromLanguageCode:String?
    
    var ToLanguageId: Int
    var ToLanguageTitle:String?
    var ToLanguageCode:String?
    var FromTitleArray: [String]
    
    var FromTitleArray1: [String] {
        return "\(FromTitle ?? "")".components(separatedBy: " ")//.shuffled()
    }
    
    
}
