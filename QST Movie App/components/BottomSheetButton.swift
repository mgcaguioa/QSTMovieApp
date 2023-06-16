//
//  BottomSheetButton.swift
//  QST Movie App
//
//  Created by Mark Caguioa on 6/16/23.
//

import SwiftUI

struct BottomSheetButton: View {
    var title: String = ""
    var action: () -> Void
    var isCancel = false
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 32
                )
                .font(.system(size: 16, weight: .semibold))
                .padding(.vertical, 8)
                .foregroundColor(isCancel ? .red.opacity(0.8) : .black.opacity(0.8))
                .lineLimit(1)
                .minimumScaleFactor(0.02)
        }
        .background(isCancel ? .red.opacity(0.2) : .gray.opacity(0.2))
        .cornerRadius(8)
    }
}

struct BottomSheetButton_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetButton(title: "YOW", action: {})
    }
}
