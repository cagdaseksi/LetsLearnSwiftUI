//
//  TopCategoryView.swift
//  LearnWithTranslation
//
//  Created by MAC on 18.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct TopCategoryView: View {
    
    @State private var topCategoryData = [Entity]()
    
    var body: some View {
        NavigationView{
            List(topCategoryData, id: \.Title) { item in
                NavigationLink(destination: CategoryView(category: item)) {
                    
                    HStack() {
                        Text(item.Title ?? "")
                            .font(.headline)
                        Text(item.ShortDescription ?? "")
                            .font(.footnote)
                    }
                
                }.navigationBarTitle("Country List")
            
        }.onAppear(perform: loadData)}
    }
}


extension TopCategoryView
{
    func loadData() {
        
        guard let url = URL(string: "http://api.bankomaclar.com/api/v1/TopCategory") else {
            return
        }
        
        let dictionary = ["email": "", "userPwd": ""]
        
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
                    let launch = try decoder.decode(Base.self, from: jsonData)
                    
                    //let deserializedValues = try JSONSerialization.jsonObject(with: data)
                    //print(deserializedValues)
                    DispatchQueue.main.async {
                        self.topCategoryData = launch.Entity
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
    
    func loadGetData() {
        
        guard let url = URL(string: "http://api.bankomaclar.com/api/v1/TopCategory") else {
            return
        }
        
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
        }

        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let json = try? decoder.decode(Base.self, from: json) {
            print(json)
        }
    }

    
}
