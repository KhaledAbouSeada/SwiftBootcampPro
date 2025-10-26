//
//  SearchView.swift
//  SwiftBootcampPro
//
//  Created by Khaled on 26/10/2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()

    var body: some View {
        VStack {
            TextField("Type something...", text: $viewModel.searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            List(viewModel.results, id: \.self) { item in
                Text(item)
            }
        }
        .padding()
    }
}


#Preview {
    SearchView()
}
