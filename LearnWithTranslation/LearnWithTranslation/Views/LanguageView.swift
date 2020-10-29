//
//  LanguageView.swift
//  LearnWithTranslation
//
//  Created by MAC on 24.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI


struct LanguageView: View {
    
    @State private var languageData = [EntityAppLanguage]()
    var subCategory: EntitySubCategory
    
    var body: some View {
        List(languageData, id: \.Id) { item in
            NavigationLink(destination: QuestionView(subCategory: self.subCategory, appLanguage: item)) {
                
                SideItem(text: "\(item.FromTitle ?? "") ➡️ \(item.ToTitle ?? "")")
            
            }.navigationBarTitle("\(self.subCategory.Title ?? "")", displayMode: .inline)
        
        }.onAppear(perform: loadData)
    }
}

extension LanguageView
{
    func loadData() {
        
        guard let url = URL(string: "\(baseUrl)/AppRootLanguage") else {
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
                    let launch = try decoder.decode(AppLanguage.self, from: jsonData)
                    
                    //let deserializedValues = try JSONSerialization.jsonObject(with: data)
                    //print(deserializedValues)
                    DispatchQueue.main.async {
                        self.languageData = launch.Entity
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
    
}
