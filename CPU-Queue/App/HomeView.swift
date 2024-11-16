//
//  Untitled.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 15/11/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: {
                    FCFSView()
                }, label: {
                    Text("FCFS")
                        .font(.custom("Impact", size: 20))
                        .padding(10)
                        .kerning(2)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                })
                
                NavigationLink(destination: {
                    RoundRobinView()
                }, label: {
                    Text("Round Robin")
                        .font(.custom("Impact", size: 20))
                        .padding(10)
                        .kerning(2)
                        .foregroundColor(.white)
                        .background(Color.purple)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: 50)
                })

            }
        }
    }
}
        
