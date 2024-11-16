//
//  ProcessesList.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 16/11/24.
//

import SwiftUI

struct ProcessesList<VM: SchedulingAlgorithm>: View {
    @Binding var processes: [Process]
    @ObservedObject var viewModel: VM
    @State private var isAddProcessPresented = false

    var body: some View {
        VStack {
            Text("Processes")
                .font(.custom("Impact", size: 25))
                .padding()

            List(processes) { process in
                HStack {
                    Text("P\(process.id)")
                        .font(.headline)
                        .frame(width: 50, alignment: .leading)
                    
                    Spacer()

                    VStack(alignment: .leading) {
                        Text("Arrival: \(process.arrivalTime)")
                            .font(.subheadline)
                        Text("Burst: \(process.burstTime)")
                            .font(.subheadline)
                    }
                }
                .padding(.vertical, 5)
            }
            
            Spacer()
            
            HStack {
                Button("Generate Processes") {
                    viewModel.fillRandomProcesses(count: Int.random(in: 1...10))
                    viewModel.reset()
                }
                .buttonStyle(.borderedProminent)

                Spacer()
                
                Button("Add Process") {
                    isAddProcessPresented.toggle()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()

        }
        .sheet(isPresented: $isAddProcessPresented) {
            AddProcessView(
                isAddProcessPresented: $isAddProcessPresented,
                viewModel: viewModel
            )
            .scrollDismissesKeyboard(.immediately)
            .menuIndicator(.visible)
            .presentationDetents([.medium])
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}
