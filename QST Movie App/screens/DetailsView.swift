//
//  DetailsView.swift
//  QST Movie App
//
//  Created by Mark Caguioa on 6/15/23.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject private var vm = DetailsViewModelImpl()
    @State private var showTrailer = false
    
    var movie: MovieModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top) {
                    Image(vm.selectedMovie?.poster ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 128)
                        .cornerRadius(4)
                    
                    Spacer().frame(width: 16)
                    
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .center) {
                            Text(vm.selectedMovie?.title ?? "")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.primary)
                            Spacer()
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                            Text("\(vm.selectedMovie?.rating?.showDecimals(decimalCount: 1) ?? "0")")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.primary)
                            Text("/ 10")
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                        }
                        
                        RoundedButton(
                            title: vm.selectedMovie?.isOnMyWatchList == true ? "REMOVE FROM WATCHLIST" : "+ ADD TO WATCHLIST",
                            action: {
                                vm.onTapAddToWatchListBtn()
                            },
                            isClearBordered: false,
                            foregroundColor: vm.selectedMovie?.isOnMyWatchList == true ? .red : .blue
                        )
                        
                        RoundedButton(
                            title: "WATCH TRAILER",
                            action: {
                                showTrailer.toggle()
                            },
                            isClearBordered: true
                        )
                    }
                }
                .padding(.bottom, 8)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Short Description")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.primary)
                    Text(vm.selectedMovie?.description ?? "")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.gray)
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Details")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.primary)
                    
                    getItemRowInfo(label: "Duration", value: vm.selectedMovie?.duration ?? "")
                    getItemRowInfo(label: "Genre", value: vm.selectedMovie?.getGenres() ?? "")
                    getItemRowInfo(label: "Released Date", value: vm.selectedMovie?.releasedDate ?? "")
                }
            }
            .padding(16)
        }
        .onAppear {
            vm.setMovie(movie: movie)
        }
        .navigationTitle("Movie Details")
        .sheet(isPresented: $showTrailer) {
            if let trailer = vm.selectedMovie?.trailerLink {
                YoutubeVideoView(ytLink: trailer)
                    .presentationDetents([.medium, .large])
            }
        }
    }
    
    @ViewBuilder func getItemRowInfo(label: String, value: String) -> some View {
        HStack(alignment: .center) {
            Text(label)
                .frame(maxWidth: 128, alignment: .trailing)
                .font(.system(size: 14, weight: .regular))
                .font(.body)
                .foregroundColor(.black)
                
            
            Text(value)
                .font(.system(size: 14, weight: .regular))
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

