//
//  ContentView.swift
//  SwiftUIMultipleButtonsListRow
//
//  Created by MAC on 17.05.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        List([1, 2, 3], id: \.self) { row in
            HStack {
              
             // 1. Button
                Button(action: {
                    print("Buton at \(row) with name A")
                }) {
                    Text("Row: \(row)" + " Button: A")
                }.buttonStyle(BorderlessButtonStyle())
             
             // 2. Button
                Button(action: {
                    print("Buton at \(row) with name B")
                }) {
                    Text("Row: \(row)" + " Button: B")
                }.buttonStyle(BorderlessButtonStyle())
             
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
