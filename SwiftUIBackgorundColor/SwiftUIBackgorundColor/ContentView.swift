//
//  ContentView.swift
//  SwiftUIBackgorundColor
//
//  Created by MAC on 14.05.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Color.red.edgesIgnoringSafeArea(.all)
            Text("Hello world")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
