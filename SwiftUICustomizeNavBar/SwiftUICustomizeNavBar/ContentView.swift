//
//  ContentView.swift
//  SwiftUICustomizeNavBar
//
//  Created by MAC on 14.05.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UINavigationBar.appearance().backgroundColor = .yellow
    }
    
    let users: [User] = [
    User(name: "Sid", imageName: "sid"),
    User(name: "Scrat", imageName: "scrat"),
    User(name: "Diego", imageName: "diego")]
    
    var body: some View {
       
        NavigationView {
            
            List(users) { user in
                
                NavigationLink (destination: DetailView(name: user.name, img: user.imageName)) {
                    
                    HStack {
                        
                        Image(user.imageName).resizable().aspectRatio(UIImage(named: user.imageName)!.size, contentMode: .fill).frame(width: 48, height: 48, alignment: .center).clipped()
                        Text(user.name)
                        
                    }
                    
                }
                
            }
            .navigationBarItems(
            leading:
                HStack {
                Button(action: {
                    print("minus")
                }){
                    Image(systemName: "minus.square.fill")
                    Text("Delete")
                }.foregroundColor(Color.red)
            },trailing:
                HStack {
                Button(action: {
                    print("plus")
                }){
                    Image(systemName: "plus.square.fill")
                    Text("Add")
                }.foregroundColor(Color.green)
            }).navigationBarTitle(Text("Ice Age Characters"))
            
        }
        
    }
}

struct DetailView: View {
    
    var name: String
    var img: String
    
    var body: some View {
        
        VStack {
            
            Image(img).resizable().aspectRatio(UIImage(named: img)!.size, contentMode: .fill).frame(width: 128, height: 128, alignment: .center).clipped()
            Text("current name is: \(name)")
                .navigationBarTitle(Text("Current User"), displayMode: .inline)
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct User: Identifiable {
    var id = UUID()
    var name = String()
    var imageName = String()
}
