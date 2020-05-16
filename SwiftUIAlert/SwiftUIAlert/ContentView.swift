//
//  ContentView.swift
//  SwiftUIAlert
//
//  Created by MAC on 15.05.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showAlert = false
    
    var alert: Alert {
        
        Alert(title: Text("Let's Learn Swift"), message: Text("Hello SwiftUI Alert"), dismissButton: .default(Text("Dismiss")))
        
    }
    
    var body: some View {
        
        ZStack {
            
            Color.green.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Button(action: {
                    
                    print(self.showAlert)
                    self.showAlert.toggle()
                    print(self.showAlert)
                    
                }) {
                    Text("Show Alert")
                }.alert(isPresented: $showAlert, content: { self.alert })
            
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
























