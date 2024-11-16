//
//  ProcessView.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 15/11/24.
//

import SwiftUI

struct ProcessView: View {
    var process: Process
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Process ID: \(process.id)")
                    .font(.headline)
                
                Spacer()
                
                if let priority = process.priority {
                    Text("Priority: \(priority)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                Text("Arrival Time: \(process.arrivalTime)")
                    .font(.subheadline)
                
                Spacer()
                
                Text("Burst Time: \(process.burstTime)")
                    .font(.subheadline)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.systemGray4), lineWidth: 1))
        .shadow(radius: 1)
    }
}

#Preview {
    ProcessView(
        process: Process(id: 1, arrivalTime: 1, burstTime: 4)
    )
}
