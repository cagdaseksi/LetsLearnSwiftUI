//
//  QuestionView.swift
//  LearnWithTranslation
//
//  Created by MAC on 20.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import UIKit
import SwiftUI

class ScoreModel: ObservableObject {
    @Published var correctCount = 0
    @Published var totalCount = 0
}

struct QuestionView: View {
    
    var subCategory: EntitySubCategory
    var appLanguage: EntityAppLanguage
    
    @ObservedObject var vm: ScoreModel = ScoreModel()
    
    @State private var questionData = [QuestionDetails]()
    @State var selectedItem: QuestionDetails?
    @State private var selectedTab = 0
    
    var body: some View {
        
        ScrollView{
            VStack {
                Picker(selection: $selectedTab, label: Text("?")) {
                       Text("Exercise").tag(0)
                       Text("Reading").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .background(Color.green).font(.body)
                .foregroundColor(.black)
                
                ForEach(questionData, id: \.QuestionId) { item in
                        
                    self.containedView(selectedTab: self.selectedTab, item: item, selectedItem: self.selectedItem, correctModel: self.vm)

                }
                .navigationBarTitle("\(appLanguage.FromTitle ?? "") -> \(appLanguage.ToTitle ?? "")", displayMode: .inline)
                .navigationBarItems(trailing:
                    Button(action: {
                        print("selam")
                    }) {
                        Text("\(vm.correctCount) / \(vm.totalCount)")
                    }//.frame(width: 35, height: 35, alignment: .center)
                    .padding()
                        .foregroundColor(.black)
                    .overlay(
                        Rectangle()
                        .stroke(Color.blue, lineWidth: 3)
                        .padding(10)
                    )
                )
            }.frame(maxWidth: .infinity)
        }.onAppear(perform: loadData)
        
    }
    
    func containedView(selectedTab: Int, item: QuestionDetails, selectedItem: QuestionDetails?, correctModel: ScoreModel) -> AnyView {
        
        var view : AnyView
        
        switch(selectedTab) {
            case 0: view = AnyView(QuestionDetailsCellButton(item: item, selectedItem: self.$selectedItem, vm: correctModel))
            case 1: view =  AnyView(QuestionDetailsCell(item: item, selectedItem: self.$selectedItem))
        default:
            view = AnyView(QuestionDetailsCellButton(item: item, selectedItem: self.$selectedItem, vm: correctModel))
        }
        
        return view
        
    }
    
}

struct QuestionDetailsCellButton: View {
    
    var item: QuestionDetails
    @Binding var selectedItem: QuestionDetails?
    @ObservedObject var vm: ScoreModel
    
    var body: some View {
        
        VStack {
            SideButton(texts: item.FromTitleArray, correctText: "\(item.FromTitle ?? "")", questionDetail: item, correctModel: vm)
        }
    }
    
    func arrayCreate() -> [String] {
        return "\(item.FromTitle ?? "")".components(separatedBy: " ")//.shuffled()
    }
    
}

struct QuestionDetailsCell: View {
    
    var item: QuestionDetails
    @Binding var selectedItem: QuestionDetails?
    @State private var showResults: Bool = false
    
    @State private var myviews = [""]
    
    var body: some View {
        
        ZStack {
            Side(text: item.FromTitle ?? "")
                .background(Color.yellow)
                .rotation3DEffect(.degrees(self.showResults ? 180.0 : 0.0), axis: (x: 0.0, y: 1.0, z: 0.0))
                //.zIndex(self.showResults ? 0 : 1)
                .opacity(self.showResults ? 0 : 1)
            Side(text: item.ToTitle ?? "")
                .background(Color.red)
                .rotation3DEffect(.degrees(self.showResults ? 0.0 : 180.0), axis: (x: 0.0, y: -1.0, z: 0.0))
                //.zIndex(self.showResults ? 1 : 0)
                .opacity(self.showResults ? 1 : 0)
        }.onTapGesture {
            self.handleFlipViewTap()
        }
        
    }
    
    private func handleFlipViewTap() -> Void
    {
        withAnimation(.easeOut(duration:0.25))
        {
            self.showResults.toggle()
        }
    }
    
}

public struct FlipView: View
{
    /// Tenemos que *dar la vuelta* a la tarjeta para
    /// ver el resultado a la pregunta.
    @State private var showResults: Bool = false
    
    public var body: some View
    {
        ZStack
        {
            Side(text: "Question?")
                .background(Color.yellow)
                .rotation3DEffect(.degrees(self.showResults ? 180.0 : 0.0), axis: (x: 0.0, y: 1.0, z: 0.0))
                .zIndex(self.showResults ? 0 : 1)
                .frame(width: 300, alignment: .center)
            Side(text: "Answer!")
                .background(Color.yellow)
                .rotation3DEffect(.degrees(self.showResults ? 0.0 : 180.0), axis: (x: 0.0, y: -1.0, z: 0.0))
                .zIndex(self.showResults ? 1 : 0)
                .frame(width: 300, alignment: .center)
        }.onTapGesture { self.handleFlipViewTap() }    }
    
    // MARK: - Actions -
    
    /**
        Al pulsar sobre la `View` cambiamos la tarjeta
        para mostrar la tarjeta con la pregunta o la
        tarjeta con la respuesta
    */
    private func handleFlipViewTap() -> Void
    {
        withAnimation(.easeOut(duration:0.25))
        {
            self.showResults.toggle()
        }
    }
}

extension QuestionView
{
    func loadData() {
        
        guard let url = URL(string: "\(baseUrl)/Question?subcategoryId=\(subCategory.Id)&fromLanguageId=\(appLanguage.FromId)&toLanguageId=\(appLanguage.ToId)") else {
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
                    let launch = try decoder.decode(Question.self, from: jsonData)
                    
                    //print(launch.Entity)
                    
                    //let deserializedValues = try JSONSerialization.jsonObject(with: data)
                    //print(deserializedValues)
                    DispatchQueue.main.async {
                        self.questionData = launch.Entity
                        self.vm.totalCount = self.questionData.count
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
