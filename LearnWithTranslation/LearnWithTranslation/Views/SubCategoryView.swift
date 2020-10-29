//
//  SubCategoryView.swift
//  LearnWithTranslation
//
//  Created by MAC on 20.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct SubCategoryView: View {
    
    var category: EntityCategory
    
    @State private var subCategoryData = [EntitySubCategory]()

    var body: some View {
        List(subCategoryData, id: \.Title) { item in
            NavigationLink(destination: LanguageView(subCategory: item)) {
                
                SideList(text: item.Title ?? "", detail: item.ShortDescription ?? "", show: self.someData(subcategoryid: item.Id))
            
            }.navigationBarTitle("\(self.category.Title ?? "")", displayMode: .inline)

        }.onAppear(perform: loadData)
    }
    
    func someData(subcategoryid: Int) -> Bool {
        return Service.v1.someEntityExists(subcategoryid: subcategoryid)
    }
    
}

extension SubCategoryView
{
    func loadData() {
        
        guard let url = URL(string: "\(baseUrl)/SubCategory/GetSubCategoriesByCategoryId?id=\(category.Id)") else {
            return
        }
        
        //let dictionary = ["email": "", "userPwd": ""]
        
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
        //request.httpBody = try! JSONEncoder().encode(dictionary)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let jsonData = data {
            
                do{
                    
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .secondsSince1970
                    let launch = try decoder.decode(SubCategory.self, from: jsonData)
                    
                    //let deserializedValues = try JSONSerialization.jsonObject(with: data)
                    //print(deserializedValues)
                    DispatchQueue.main.async {
                        self.subCategoryData = launch.Entity
                        self.getAllCategory(subCategoryData: self.subCategoryData, categoryId: self.category.Id)
                    }
                }
                catch {
                    print(error)
                }
                
                
            }
            
            //print(data)
            //print(response)
            //print(error)
            
        }.resume()
    }
    
    func getAllCategory(subCategoryData: [EntitySubCategory], categoryId: Int) {
        
        //Service.v1.deleteAllData(entity: "CategoryCore")
        //Service.v1.deleteAllData(entity: "SubCategoryCore")
        
        let subcategoryCoreDatas = Service.v1.getAllSubCategory()
        var count = 0
        for sub in subCategoryData {
            let any = subcategoryCoreDatas.filter{ $0.subcategoryid == sub.Id }
            count = any.isEmpty ? count : count + 1
        }
        print("count:" , count)
        print("database", subCategoryData.count)
        print("coredata", subcategoryCoreDatas.count)
        
        if count == subCategoryData.count && Service.v1.someEntityExists(categoryid: categoryId) == false {
            print("createCategoryData: \(count) == \(subCategoryData.count) | some: \(Service.v1.someEntityExists(categoryid: categoryId) == false)")
            
            Service.v1.createCategoryData(categoryCore: CategoryCoreData(isdone: true, categoryId: categoryId))
        }
        
    }
    
}
