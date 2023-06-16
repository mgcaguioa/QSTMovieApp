//
//  ListView.swift
//  QST Movie App
//
//  Created by Mark Caguioa on 6/15/23.
//

import SwiftUI

struct ListView: View {
    
    @StateObject private var vm = ListViewModelImpl()
    
    var body: some View {
        NavigationStack {
            List(vm.movies) { movie in
                NavigationLink(value: movie) {
                    getItemRow(item: movie)
                }
            }
            .navigationDestination(for: MovieModel.self) { item in
                DetailsView(movie: item)
            }
            .navigationTitle("Movies")
            .toolbar {
                Button("Sort") {
                    vm.onTapSortBtn()
                }
            }
            .onAppear {
                Task {
                    // subsequent load - when user navigates back from detailsView
                    await vm.getList()
                }
            }
        }
        .onAppear {
            Task {
                // initial load - when user opens the app
                await vm.getList()
            }
        }
        .sheet(isPresented: $vm.showSortOptions) {
            VStack(spacing: 2) {
                Spacer().frame(height: 8)
                
                BottomSheetButton(
                    title: "Title",
                    action: {
                        vm.sortByTitle()
                        vm.showSortOptions = false
                    },
                    isCancel: false
                )
                
                BottomSheetButton(
                    title: "Released Date",
                    action: {
                        vm.sortByDate()
                        vm.showSortOptions = false
                    },
                    isCancel: false
                )
                
                Spacer().frame(height: 8)
                
                BottomSheetButton(
                    title: "Cancel",
                    action: { vm.showSortOptions = false },
                    isCancel: true
                )
            }
            .padding(8)
            .presentationDetents([.height(170)])
        }
    }
    
    @ViewBuilder func getItemRow(item: MovieModel) -> some View {
        HStack (alignment: .center) {
            Image(item.poster ?? "")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 128)
                .cornerRadius(4)
            
            Spacer().frame(width: 16)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text("\(item.title ?? "") (\(item.getYear()))")
                    .font(Font.title2.weight(.bold))
                    .foregroundColor(Color.primary)
                
                VStack(alignment: .leading) {
                    getItemRowInfo(iconName: "stopwatch", text: item.duration ?? "")
                    getItemRowInfo(iconName: "theatermasks.fill", text: item.getGenres())
                }
                
                Text(item.isOnMyWatchList == true ? "ON MY WATCHLIST" : "")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
            }
        }
    }
    
    @ViewBuilder func getItemRowInfo(iconName: String, text: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .frame(width: 32)
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text(text)
                .font(.footnote)
                .foregroundColor(Color.gray)
        }
    }
}
