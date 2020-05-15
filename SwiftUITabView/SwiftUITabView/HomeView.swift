//
//  HomeView.swift
//  SwiftUITabView
//
//  Created by MAC on 15.05.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            
            Color.red.edgesIgnoringSafeArea(.all)
            Text("Home View")
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
