//
//  ContentView.swift
//  SwiftUISideMenu
//
//  Created by MAC on 13.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

// 1 Menu Content
struct MenuContent: View {
    var body: some View {
        List {
            Text("My Profile").onTapGesture {
                print("My profile.")
            }
            Text("Posts").onTapGesture {
                print("Posts.")
            }
            Text("Logout").onTapGesture {
                print("Logout.")
            }
        }
    }
}

//2. Side menu
struct SideMenu: View {
    
    //variables
    let width: CGFloat
    let isOpen: Bool
    let menuClose: () -> Void
    
    var body: some View {
        
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.3))
            .opacity(self.isOpen ? 1.0 : 0.0)
            .animation(Animation.easeIn.delay(0.25))
            .onTapGesture {
                self.menuClose()
            }
            
            HStack {
                MenuContent()
                    .frame(width: self.width)
                    .background(Color.white)
                    .offset(x: self.isOpen ? 0 : -self.width)
                    .animation(.default)
                Spacer()
            }
            
        }
        
    }
    
}

//3. Content View
struct ContentView: View {
    
    @State var menuOpen: Bool = false
    
    var body: some View {
        ZStack {
            if self.menuOpen == false {
                Button(action: {
                    self.openMenu()
                }, label: { Text("Open") })
            }
            
            SideMenu(width: 270, isOpen: self.menuOpen, menuClose: self.openMenu)
            
        }
    }
    
    func openMenu(){
        self.menuOpen.toggle()
    }
}

