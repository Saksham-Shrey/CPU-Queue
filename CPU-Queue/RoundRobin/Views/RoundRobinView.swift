//
//  RoundRobinView.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 16/11/24.
//


import SwiftUI

struct RoundRobinView: View {
    @StateObject private var viewModel = RoundRobinViewModel()
    @State private var isProcessesSheetPresented = false
    @State private var runMode: RunMode = .automatic
    @State private var quantum: Int = 0 // Default time quantum

    var body: some View {
        VStack {
        ScrollView(showsIndicators: false) {
                
                // Run Mode Selection
                Picker("Run Mode", selection: $runMode) {
                    Text("Automatic").tag(RunMode.automatic)
                        .fontWeight(.bold)
                    
                    Text("Manual").tag(RunMode.manual)
                        .fontWeight(.bold)
                }
                .onChange(of: runMode, {
                    viewModel.reset()
                })
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                
                // Quantum Selection
                HStack {
                    VStack {
                        Text("Quantum Time:")
                            .font(.headline)
                        TextField("Quantum", value: $quantum, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.center)
                            .frame(width: 60)
                            .padding(5)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray)
                                    .shadow(color: Color.black, radius: 1)
                            )
                        if quantum <= 0 {
                            Text("Time Quantum must be greater than 0 !!")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                    }
                }
                .padding(5)
                .onChange(of: quantum) {
                    viewModel.reset()
                }
                
                Spacer()
                
                // Processes Table Section
                if !viewModel.processes.isEmpty {
                    ProcessesTable(processes: viewModel.processes)
                        .padding(.horizontal)
                }
                
                Spacer()
                
                // Manual Controls
                if runMode == .manual && !viewModel.ganttChartData.isEmpty {
                    HStack {
                        Button("Previous") {
                            viewModel.showPreviousGanttItem()
                        }
                        .buttonStyle(.bordered)
                        .disabled(viewModel.currentIndex <= 0)
                        
                        Spacer()
                        
                        Button("Next") {
                            viewModel.showNextGanttItem()
                        }
                        .buttonStyle(.bordered)
                        .disabled(viewModel.currentIndex >= viewModel.ganttChartData.count - 1)
                    }
                    .padding()
                    .offset(y: 30)
                }
                
                // Gantt Chart Section
                if !viewModel.displayedProcesses.isEmpty {
                    Text("Gantt Chart")
                        .font(.headline)
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.displayedProcesses) { item in
                                VStack {
                                    Text("P\(item.processId)")
                                        .font(.caption)
                                    Rectangle()
                                        .fill(Color.green)
                                        .frame(width: CGFloat(item.duration) * 20, height: 30)
                                    Text("\(item.startTime) - \(item.endTime)")
                                        .font(.caption2)
                                }
                            }
                        }
                        .padding()
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
            }
            .padding(10)
            .scrollDismissesKeyboard(.immediately)
            
            Spacer()
            
            // Bottom Toolbar
            HStack {
                Button("Processes") {
                    isProcessesSheetPresented.toggle()
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Run Round Robin") {
                    viewModel.runScheduling(runMode: runMode, quantum: quantum)
                }
                .buttonStyle(.borderedProminent)
                
            }
            .padding()

        }
        .onAppear {
            viewModel.fillRandomProcesses(count: 5)
        }
        .onDisappear {
            viewModel.reset()
        }
        .sheet(isPresented: $isProcessesSheetPresented) {
            ProcessesList(processes: $viewModel.processes, viewModel: viewModel)
        }
    }
}

#Preview {
    RoundRobinView()
}
