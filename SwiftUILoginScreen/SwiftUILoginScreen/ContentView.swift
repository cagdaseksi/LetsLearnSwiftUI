//
//  ContentView.swift
//  SwiftUILoginScreen
//
//  Created by MAC on 13.05.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack{
            Color.green.edgesIgnoringSafeArea(.all)
            VStack {
                WelcomeView()
                ImageView()
                LoginView()
            }
        }
        
    }
}


struct WelcomeView: View{
    
    var body: some View {
        return Text("SwiftUI").foregroundColor(.white).padding(.bottom, 20).font(.largeTitle)
    }
    
}

struct ImageView: View {
    
    var body: some View {
        
        return Image("logo").resizable().aspectRatio(UIImage(named: "logo")!.size, contentMode: .fill).frame(width: 128, height: 128, alignment: .center).clipped().padding(.bottom, 50)
        
    }
    
}

struct LoginView: View {
    
    @State var username = ""
    @State var password = ""
    
    var body: some View {
        
        return VStack {
            
            VStack {
                
                HStack(spacing: 15) {
                    
                    Image(systemName: "envelope").foregroundColor(.black)
                    TextField("Enter email address", text: self.$username)
                    
                }.padding(.vertical, 20)
                
                Divider()
                
                HStack(spacing: 15) {
                    
                    Image(systemName: "lock").foregroundColor(.black)
                    SecureField("Password", text: self.$password)
                    
                }.padding(.vertical, 20)
                
                
                
            }.padding(.vertical).padding(.horizontal, 20).padding(.bottom, 40).background(Color.white)
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
