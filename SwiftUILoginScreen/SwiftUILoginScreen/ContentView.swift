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
            }.padding()
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
                    
                    Button(action:{
                        print("show password")
                    }){
                        Image(systemName: "eye").foregroundColor(.black)
                    }
                    
                }.padding(.vertical, 20)
                
            }.padding(.vertical)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.top, 0)
            
            Button("Sign in") {
                print("username: \(self.username), password: \(self.password)")
            }.font(.headline).foregroundColor(Color.white)
                .frame(width: UIScreen.main.bounds.width - 100, height: 60, alignment: .center)
                .background(Color.blue)
                .cornerRadius(15.0)
                .offset(y: -40)
                .padding(.bottom, -40)
            
            Text("Forgot password").foregroundColor(Color.white).padding(.top, 20)
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
