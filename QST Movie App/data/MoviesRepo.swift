//
//  MoviesRepo.swift
//  QST Movie App
//
//  Created by Mark Caguioa on 6/15/23.
//

import SwiftUI

final class MoviesRepo {
    
    @AppStorage("QST_APP_MOVIES") private var moviesJsonStr = ""
    
    func updateMovieWatchList(movie: MovieModel) {
        var tempMovies = getMovies()
        let indexToUpdate = tempMovies.firstIndex(where: { $0.id == movie.id })
        if let index = indexToUpdate {
            tempMovies[index].isOnMyWatchList?.toggle()
            
            do {
                let data = try JSONEncoder().encode(tempMovies)
                if let jsonStr = String(data: data, encoding: .utf8) {
                    self.moviesJsonStr = jsonStr
                }
            } catch {
                debugPrint("yow.MoviesRepo.updateMovieWatchList.error \(error)")
            }
        }
    }
    
    func getMovies() -> [MovieModel] {
        do {
            if !moviesJsonStr.isEmpty {
                return try JSONDecoder().decode([MovieModel].self, from:  Data(self.moviesJsonStr.utf8))
            }
            return try JSONDecoder().decode([MovieModel].self, from:  Data(self.dummyData.utf8))
            
        } catch {
            print("yow.MoviesRepo.getMovies.error: \(error)")
        }
        return []
    }
    
    private var dummyData = """
    [
      {
        "id": 1,
        "title": "Tenet",
        "poster": "Tenet",
        "description": "Armed with only one word, Tenet, and fighting for the survival of the entire world, a Protagonist journeys through a twilight world of international espionage on a mission that will unfold in something beyond real time.",
        "rating": 7.8,
        "duration": "2h 30 min",
        "genre": [
          "Action",
          "Sci-Fi"
        ],
        "releasedDate": "3 September 2020",
        "trailerLink": "https://www.youtube.com/embed/LdOM0x0XDMo",
        "isOnMyWatchList": false
      },
      {
        "id": 2,
        "title": "Spider-Man: Into the Spider-Verse",
        "poster": "SpiderMan",
        "description": "Teen Miles Morales becomes the Spider-Man of his universe, and must join with five spider-powered individuals from other dimensions to stop a threat for all realities.",
        "rating": 8.4,
        "duration": "1h 57min",
        "genre": [
          "Action",
          "Animation",
          "Adventure"
        ],
        "releasedDate": "14 December 2018",
        "trailerLink": "https://www.youtube.com/embed/tg52up16eq0",
        "isOnMyWatchList": false
      },
      {
        "id": 3,
        "title": "Knives Out",
        "poster": "KnivesOut",
        "description": "A detective investigates the death of a patriarch of an eccentric, combative family.",
        "rating": 7.9,
        "duration": "2h 10min",
        "genre": [
          "Comedy",
          "Crime",
          "Drama"
        ],
        "releasedDate": "27 November 2019",
        "trailerLink": "https://www.youtube.com/embed/qGqiHJTsRkQ",
        "isOnMyWatchList": false
      },
      {
        "id": 4,
        "title": "Guardians of the Galaxy",
        "poster": "GuardiansOfTheGalaxy",
        "description": "A group of intergalactic criminals must pull together to stop a fanatical warrior with plans to purge the universe.",
        "rating": 8,
        "duration": "2h 1min",
        "genre": [
          "Action",
          "Adventure",
          "Comedy"
        ],
        "releasedDate": "1 August 2014",
        "trailerLink": "https://www.youtube.com/embed/d96cjJhvlMA",
        "isOnMyWatchList": false
      },
      {
        "id": 5,
        "title": "Avengers: Age of Ultron",
        "poster": "Avengers",
        "description": "When Tony Stark and Bruce Banner try to jump-start a dormant peace keeping program called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop the villainous Ultron from enacting his terrible plan.",
        "rating": 7.3,
        "duration": "2h 21min",
        "genre": [
          "Action",
          "Adventure",
          "Sci-Fi"
        ],
        "releasedDate": "1 May 2015",
        "trailerLink": "https://www.youtube.com/embed/tmeOjFno6Do",
        "isOnMyWatchList": false
      }
    ]
    """
}
