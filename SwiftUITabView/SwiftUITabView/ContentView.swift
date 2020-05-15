//
//  ContentView.swift
//  SwiftUITabView
//
//  Created by MAC on 15.05.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            
            HomeView().tabItem {
                
                VStack {
                    Image(systemName: "1.circle")
                    Text("HOME")
                }
                
            }.tag(1)
            
            SettingsView().tabItem {
                
                VStack{
                    
                    Image(systemName: "2.circle")
                    Text("SETTINGS")
                    
                }
                
            }.tag(2)
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
