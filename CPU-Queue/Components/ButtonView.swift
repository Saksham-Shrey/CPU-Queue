//
//  ButtonView.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 15/11/24.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            Text("\(title)")
                .font(.custom("Impact", size: 20))
                .padding(10)
                .kerning(2)
                .foregroundColor(.white)
                .background(Color.purple)
                .cornerRadius(15)
                .frame(maxWidth: .infinity, maxHeight: 50)
        }
    }
}

#Preview("Button View") {
    ButtonView(title: "Click Me") {
        print("Button Clicked")
    }
}
