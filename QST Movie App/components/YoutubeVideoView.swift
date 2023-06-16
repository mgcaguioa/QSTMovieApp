//
//  YoutubeVideoView.swift
//  QST Movie App
//
//  Created by Mark Caguioa on 6/16/23.
//

import SwiftUI
import WebKit

struct YoutubeVideoView: UIViewRepresentable {
    
    var ytLink: String
    
    func makeUIView(context: Context) -> WKWebView  {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: ytLink) else { return }
        
        uiView.scrollView.isScrollEnabled = false
        uiView.load(.init(url: url))
    }
}
