//
//  AddProcessView.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 15/11/24.
//

import SwiftUI

struct AddProcessView<VM: SchedulingAlgorithm>: View {
    @Binding var isAddProcessPresented: Bool
    @ObservedObject var viewModel: VM
    
    @State private var arrivalTime = 0
    @State private var burstTime = 2
    
    var body: some View {
        VStack {
            HStack {
                VStack(spacing: 10) {
                    Text("Arrival Time:")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    TextField("Arrival Time", value: $arrivalTime, formatter: NumberFormatter())
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                                .fill(Color.clear)
                                .shadow(color: Color.black, radius: 1)
                        }
                }
                .padding(10)
                
                
                VStack(spacing: 10) {
                    Text("Burst Time:")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    TextField("Burst Time", value: $burstTime, formatter: NumberFormatter())
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray, lineWidth: 1)
                                .fill(Color.clear)
                                .shadow(color: Color.black, radius: 1)
                        }
                }
                .padding(10)
                
            }
            
            ButtonView(title: "Add Process") {
                viewModel.processes
                    .append(
                        Process(
                            id: viewModel.processes.count + 1,
                            arrivalTime: arrivalTime,
                            burstTime: burstTime
                        )
                    )
                
                arrivalTime = -1
                burstTime = -1
                
                isAddProcessPresented.toggle()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
    }
}


