//
//  ContentView.swift
//  SwiftUINavigationViewPopToRoot
//
//  Created by MAC on 17.05.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            NavigationLink(destination: SecondView(rootIsActive: self.$isActive), isActive: self.$isActive) {
                
                Text("Home View!")
                
                
            }.isDetailLink(false)
                .navigationBarTitle("Root", displayMode: .inline)
            
        }
        
    }
}

struct SecondView: View {
    
    @Binding var rootIsActive: Bool
    
    var body: some View {
        
        ZStack {
            
            Color.purple.edgesIgnoringSafeArea(.all)
            
            NavigationLink(destination: ThirdView(shouldPopToRoot: self.$rootIsActive)) {
                
                Text("Second View!")
                
            }.isDetailLink(false)
                .navigationBarTitle("Two", displayMode: .inline)
            
        }
        
    }
    
}

struct ThirdView: View {
    
    @Binding var shouldPopToRoot: Bool
    
    var body: some View {
        
        ZStack {
            
            Color.green.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("Third View!")
                Button(action: {
                    self.shouldPopToRoot = false
                }) {
                    Text("Pop to Root")
                }
                
            }.navigationBarTitle("Three", displayMode: .inline)
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
