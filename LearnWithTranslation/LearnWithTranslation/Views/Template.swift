//
//  Template.swift
//  LearnWithTranslation
//
//  Created by MAC on 24.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import Foundation
import SwiftUI
import AVFoundation

public struct SideButton: View
{
    @State public var texts = [String]()
    @State public var correctText = ""
    @State public var text = ""
    @State public var dummyText = "?"
    @State private var totalHeight = CGFloat.zero
    @State var correct = false
    @State var questionDetail: QuestionDetails
    @State private var selectedButtons: [String] = [String]()
    
    @ObservedObject var correctModel: ScoreModel
    @State private var showingAlert = false
    
    let group = DispatchGroup()
    let semaphore = DispatchSemaphore(value: 0)
    
    public var body: some View
    {
        VStack(spacing: 5) {
            Text("\(questionDetail.ToTitle ?? "")")
                .font(.headline)
                .lineLimit(10)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                .padding(10).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
                .background(Color.yellow)
            //Divider()
            Text("\(self.dummyText)\(self.text)")
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.all, 5)
                .background(self.correct ? Color.green : Color.red)
                .foregroundColor(Color.black)
                .cornerRadius(5)
                .lineLimit(10)
                .font(.headline)
            VStack {
                GeometryReader { geometry in
                    self.generateContent(in: geometry)
                }
            }
            .frame(height: totalHeight)
            Divider()
            HStack {
                Text("Reset").onTapGesture {
                
                self.reset()
                
                }
                .padding(4)
                .background(Color.gray)
                .foregroundColor(Color.white)
                .cornerRadius(4)
                Text("Listen").onTapGesture {
                
                    self.listen(item: self.questionDetail)
                
                }
                .padding(4)
                .background(Color.gray)
                .foregroundColor(Color.white)
                .cornerRadius(4)
            }
            Divider()
            }
            .background(Color.blue)
            .cornerRadius(11)
            .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        
        var width = CGFloat.zero
        var height = CGFloat.zero
        var count = 0
        
        let view = ZStack(alignment: .topLeading) {
            ForEach(self.texts, id: \.self) { tag in
                
                self.item(for: tag)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        
                        let result = width
                        
                        count = count + 1
                        
                        if count == self.texts.count {
                            width = 0
                            
                        }else {
                             width -= d.width
                        }
                        
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        
                        let result = height
                        
                        if count == self.texts.count {
                            height = 0
                            count = 0
                        }
                        
                        return result
                    })
            }
        }
        
        return view.background(self.viewHeightReader(self.$totalHeight))
        
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geometry -> Color in
            let rect = geometry.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
               //self.semaphore.wait()
                //print("wait")
            }
            //self.semaphore.signal()
            //print("signal")
            return .clear
        }
    }
    
    func item(for text: String) -> some View {
        
        Button(action: {
            self.dummyText = ""
            self.text += "\(text) "
            let t = self.text.trimmingCharacters(in: .whitespacesAndNewlines)
            self.correct = t == self.correctText
            self.correctModel.correctCount = self.correct ? self.correctModel.correctCount + 1 : self.correctModel.correctCount
            //print(self.correctText)
            //print(self.text)
            self.showingAlert = self.correctModel.correctCount == self.correctModel.totalCount
            
            if self.showingAlert {
                self.saveData(subcategoryid: self.questionDetail.SubCategoryId)
            }
            
            self.updateSelectedButtons(value: text)
            
            })
        {
            Text("\(text)").padding(5)
        }
        .padding(.all, 5)
        .font(.body)
        .background(self.selectedButtons.contains(where: { $0 == text }) ? Color.yellow : Color.white)
        //.background(Color.yellow)
        .foregroundColor(Color.black)
        .cornerRadius(5)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("👌 CONGRATULATIONS 👌"), message: Text("Tüm cümleleri doğru çevirerek bu seviyeyi tamamladın."), dismissButton: .default(Text("Keep up the good work")))
        }
        //.buttonStyle(MyButtonStyle())
        //.opacity(self.selectedButtons.contains(text) ? 0 : 1)
    }
    
    func reset() {
        self.text = ""
        self.dummyText = "?"
        self.selectedButtons.removeAll()
    }
    
    func listen(item: QuestionDetails) {
        let utterance = AVSpeechUtterance(string: item.ToTitle ?? "")
        utterance.voice = AVSpeechSynthesisVoice(language: item.ToLanguageCode)
        utterance.rate = 0.5
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func saveData(subcategoryid: Int) {
        
        print("savedata")
        let sub = SubCategoryCoreData(isdone: true, subCategoryId: subcategoryid)
        Service.v1.createData(subCategoryCore: sub)
        
    }
    
    func updateSelectedButtons(value: String) {
        //print(self.selectedButtons)
        //print(value)
        if self.selectedButtons.contains(value) {
            if let index = self.selectedButtons.firstIndex(of: value) {
                self.selectedButtons.removeFirst(index)
            }
        } else {
            self.selectedButtons.append(value)
        }
    }
    
}

struct MyButtonStyle: ButtonStyle {

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label.background(configuration.isPressed ? Color.green : Color.yellow)
  }

}

public struct Side: View
{
    /// El contenido de la tarjeta. Puede ser
    /// una pregunta o una respuesta.
    @State public var text: String = ""
    
    public var body: some View
    {
        Text(self.text)
            .font(.title)
            .fontWeight(.light)
            .padding(2).frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
            ).multilineTextAlignment(.leading).fixedSize(horizontal: false, vertical: true)
    }
}

public struct SideList: View
{
    /// El contenido de la tarjeta. Puede ser
    /// una pregunta o una respuesta.
    @State public var text: String = ""
    @State public var detail: String = ""
    @State public var show: Bool = false
    
    public var body: some View
    {
        VStack() {
        Text(self.text)
            .font(.headline)
            .fontWeight(.bold)
            .padding(10)
        Text(self.detail)
            .font(.footnote)
            .fontWeight(.light)
            .padding(10)
        }.frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
            ).padding(10).background(self.show ? Color.green : Color.yellow)
    }
}

public struct SideItem: View
{
    /// El contenido de la tarjeta. Puede ser
    /// una pregunta o una respuesta.
    @State public var text: String = ""
    
    public var body: some View
    {
        VStack() {
        Text(self.text)
            .font(.headline)
            .fontWeight(.bold)
            .padding(10).frame(minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center
        ).padding(10).background(Color.yellow)
        }
    }
}
