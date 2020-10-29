//
//  CategoryView.swift
//  LearnWithTranslation
//
//  Created by MAC on 19.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    
    var topCategory: EntityTopCategory
    
    @State private var categoryData = [EntityCategory]()
    
    var body: some View {
        
        List(categoryData, id: \.Title) { item in
            NavigationLink(destination: SubCategoryView(category: item)) {
                
                SideList(text: item.Title ?? "", detail: item.ShortDescription ?? "", show: self.someData(categoryid: item.Id))
            
            }.navigationBarTitle("\(self.topCategory.Title ?? "")", displayMode: .inline)

        }.onAppear(perform: loadData)
    }
    
    func someData(categoryid: Int) -> Bool {
        //Service.v1.delete(entity: "CategoryCore")
        //Service.v1.delete(entity: "SubCategoryCore")
        //print("somedata: \(Service.v1.someEntityExists(categoryid: categoryid))")
        return Service.v1.someEntityExists(categoryid: categoryid)
    }
    
}

extension CategoryView
{
    func loadData() {
        
        guard let url = URL(string: "\(baseUrl)/Category/GetCategoriesByTopCategoryId?id=\(topCategory.Id)") else {
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
                    let launch = try decoder.decode(Category.self, from: jsonData)
                    
                    //let deserializedValues = try JSONSerialization.jsonObject(with: data)
                    //print(deserializedValues)
                    DispatchQueue.main.async {
                        self.categoryData = launch.Entity
                        self.getAllCategory(categoryData: self.categoryData, topCategoryId: self.topCategory.Id)
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
    
    func getAllCategory(categoryData: [EntityCategory], topCategoryId: Int) {
        
        //Service.v1.deleteAllData(entity: "CategoryCore")
        //Service.v1.deleteAllData(entity: "SubCategoryCore")
        
        let categoryCoreDatas = Service.v1.getAllCategory()
        var count = 0
        for sub in categoryData {
            let any = categoryCoreDatas.filter{ $0.categoryid == sub.Id }
            count = any.isEmpty ? count : count + 1
        }
        print("count:" , count)
        print("database", categoryData.count)
        print("coredata", categoryCoreDatas.count)
        
        if count == categoryData.count && Service.v1.someEntityExists(topCategoryid: topCategoryId) == false {
            print("createCategoryData: \(count) == \(categoryData.count) | some: \(Service.v1.someEntityExists(topCategoryid: topCategoryId) == false)")
            
            Service.v1.createTopCategoryData(topCategoryCore: TopCategoryCoreData(isdone: true, topCategoryId: topCategoryId))
        }
        
    }
    
}
