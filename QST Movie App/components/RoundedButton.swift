//
//  RoundedButton.swift
//  QST Movie App
//
//  Created by Mark Caguioa on 6/16/23.
//

import SwiftUI

struct RoundedButton: View {
    var title: String = ""
    var action: () -> Void
    var isClearBordered = false
    var foregroundColor = Color.blue
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(minHeight: 16)
                .font(.system(size: 12, weight: .semibold))
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .foregroundColor(isClearBordered ? .black : foregroundColor)
                .lineLimit(1)
                .minimumScaleFactor(0.02)
        }
        .overlay(RoundedRectangle(cornerRadius: 32)
            .stroke(isClearBordered ? .black : foregroundColor.opacity(0.2), lineWidth: 4)
        )
        .background(isClearBordered ? .white.opacity(0) : foregroundColor.opacity(0.2))
        .cornerRadius(32)
    }
}

struct RoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(title: "YOW", action: {})
    }
}
