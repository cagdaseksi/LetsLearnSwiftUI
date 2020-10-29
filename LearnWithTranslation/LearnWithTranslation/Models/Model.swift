//
//  Model.swift
//  LearnWithTranslation
//
//  Created by MAC on 19.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import Foundation

struct TopCategory: Decodable {
    var Status: Bool
    var Message:String
    var Entity: [EntityTopCategory]
    
}

struct EntityTopCategory: Decodable {
    var Id: Int
    var AppKey:String?
    var Title:String?
    var Icon:String?
    var ShortDescription:String?
    var Description:String?
    var Categories: String?
}

struct Category: Decodable {
    var Status: Bool
    var Message:String
    var Entity: [EntityCategory]
    
}

struct EntityCategory: Decodable {
    var Id: Int
    var TopCategoryId: Int
    var AppKey:String?
    var Title:String?
    var Icon:String?
    var ShortDescription:String?
    var Description:String?
    var SubCategories: String?
}

struct SubCategory: Decodable {
    
    var Status: Bool
    var Message:String
    var Entity: [EntitySubCategory]
}

struct EntitySubCategory: Decodable {
    
    var Id: Int
    var CategoryId: Int
    var AppKey:String?
    var Title:String?
    var Icon:String?
    var ShortDescription:String?
    var Description:String?
    var Questions: String?
    
}


struct AppLanguage: Decodable {
    var Status: Bool
    var Message:String
    var Entity: [EntityAppLanguage]
    
}

struct EntityAppLanguage: Decodable {
    var Id: Int
    var FromId:Int
    var ToId:Int
    var FromTitle:String?
    var ToTitle:String?
    var FromIcon:String?
    var ToIcon: String?
}

struct Answer {
    var index: Int
    var value: String
}

class SubCategoryCoreData{
    var isDone: Bool
    var subCategoryId: Int
    
    init(isdone: Bool, subCategoryId: Int){
        self.isDone = isdone
        self.subCategoryId = subCategoryId
    }
    
}

class CategoryCoreData{
    var isDone: Bool
    var categoryId: Int
    
    init(isdone: Bool, categoryId: Int){
        self.isDone = isdone
        self.categoryId = categoryId
    }
    
}

class TopCategoryCoreData{
    var isDone: Bool
    var topCategoryId: Int
    
    init(isdone: Bool, topCategoryId: Int){
        self.isDone = isdone
        self.topCategoryId = topCategoryId
    }
    
}
