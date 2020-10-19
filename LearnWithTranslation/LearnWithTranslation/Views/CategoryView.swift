//
//  CategoryView.swift
//  LearnWithTranslation
//
//  Created by MAC on 19.10.2020.
//  Copyright © 2020 cagdaseksi. All rights reserved.
//

import SwiftUI

struct CategoryView: View {
    var category: Entity
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(category.Title ?? "")
                .font(.headline)
            Text(category.Title ?? "")
                .font(.footnote)
        }
    }
}
