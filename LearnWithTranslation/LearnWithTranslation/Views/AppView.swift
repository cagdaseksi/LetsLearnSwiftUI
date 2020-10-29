//
//  AppView.swift
//  LearnWithTranslation
//
//  Created by MAC on 18.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            TopCategoryView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("HOME")
                }

            HomeView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("ABOUT")
                }
        }
    }
}

