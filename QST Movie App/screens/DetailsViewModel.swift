//
//  DetailsViewModel.swift
//  QST Movie App
//
//  Created by Mark Caguioa on 6/15/23.
//

import SwiftUI

// protocols make testing easier
protocol DetailsViewModel: ObservableObject {
    func onTapAddToWatchListBtn() async
    func setMovie(movie: MovieModel) async
}

@MainActor
final class DetailsViewModelImpl: DetailsViewModel {
    
    @Published var selectedMovie: MovieModel?
    
    private let repo = MoviesRepo()
    
    func onTapAddToWatchListBtn() {
        if let movie = selectedMovie {
            repo.updateMovieWatchList(movie: movie)
            selectedMovie = repo.getMovies().first(where: { $0.id == selectedMovie?.id })
        }
    }
    
    func setMovie(movie: MovieModel) {
        selectedMovie = movie
    }
}

