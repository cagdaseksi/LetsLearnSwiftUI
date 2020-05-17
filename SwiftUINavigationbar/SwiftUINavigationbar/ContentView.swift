//
//  ContentView.swift
//  SwiftUINavigationbar
//
//  Created by MAC on 16.05.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                Text("Don't use .appearence()!")
            }.navigationBarTitle("Try It!", displayMode: .inline)
                .background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = .red
                    nc.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            })
        }.navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
