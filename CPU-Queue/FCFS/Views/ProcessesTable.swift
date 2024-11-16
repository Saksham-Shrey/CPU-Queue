//
//  ProcessesTable.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 16/11/24.
//

import SwiftUI

struct ProcessesTable: View {
    var processes: [Process]

    var body: some View {
            VStack(alignment: .leading) {
                // Header Row
                HStack {
                    Text("P-ID")
                        .font(.headline)
                        .frame(width: 50, alignment: .center)
                    Text("AT")
                        .font(.headline)
                        .frame(width: 50, alignment: .center)
                    Text("BT")
                        .font(.headline)
                        .frame(width: 50, alignment: .center)
                    Text("CT")
                        .font(.headline)
                        .frame(width: 50, alignment: .center)
                    Text("WT")
                        .font(.headline)
                        .frame(width: 50, alignment: .center)
                    Text("TAT")
                        .font(.headline)
                        .frame(width: 50, alignment: .center)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(5)

                Divider()

                // Process Rows
                ForEach(processes) { process in
                    HStack {
                        Text("P\(process.id)")
                            .frame(width: 50, alignment: .center)
                        Text("\(process.arrivalTime)")
                            .frame(width: 50, alignment: .center)
                        Text("\(process.burstTime)")
                            .frame(width: 50, alignment: .center)
                        Text("\(process.completionTime ?? 0)")
                            .frame(width: 50, alignment: .center)
                        Text("\(process.waitingTime ?? 0)")
                            .frame(width: 50, alignment: .center)
                        Text("\(process.turnAroundTime ?? 0)")
                            .frame(width: 50, alignment: .center)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                }
            }
            .padding()
            .background(Color(.systemGray4))
            .cornerRadius(10)
    }
}
