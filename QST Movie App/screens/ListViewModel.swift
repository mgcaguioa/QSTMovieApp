//
//  ListViewModel.swift
//  QST Movie App
//
//  Created by Mark Caguioa on 6/15/23.
//

import Foundation

// protocols make testing easier
protocol ListViewModel: ObservableObject {
    func onTapSortBtn() async
    func getList() async
    func sortByTitle() async
    func sortByDate() async
}

@MainActor
final class ListViewModelImpl: ListViewModel {
    
    @Published var showDetailsView = false
    @Published var showSortOptions = false
    @Published var movies: [MovieModel] = []
    
    private let repo = MoviesRepo()
    
    func onTapSortBtn() {
        showSortOptions = true
    }
    
    func getList() async {
        movies = repo.getMovies()
    }
    
    func sortByTitle() {
        movies = movies.sorted(by: {
            ($0.title ?? "").compare($1.title ?? "") == .orderedAscending
        })
    }
    
    func sortByDate() {
        movies = movies.sorted(by: {
            ($0.releasedDate ?? "").compare($1.releasedDate ?? "") == .orderedDescending
        })
    }
}
