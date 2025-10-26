//
//  SearchViewModel.swift
//  SwiftBootcampPro
//
//  Created by Khaled on 26/10/2025.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var results: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                self?.performSearch(query: text)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(query: String) {
        guard !query.isEmpty else {
            results = []
            return
        }
        results = ["Result for \(query)", "Another \(query) item"]
    }
}
