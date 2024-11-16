//
//  FCFSView.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 15/11/24.
//

import SwiftUI

struct FCFSView: View {
    @StateObject private var viewModel = FCFSViewModel()
    @State private var isProcessesSheetPresented = false
    @State private var runMode: RunMode = .automatic

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
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: runMode) {
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
                    .offset(y: 40)
                }
                
                Spacer()
                
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
                                        .fill(Color.red.gradient)
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
            
            HStack {
                Button("Processes") {
                    isProcessesSheetPresented.toggle()
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Run FCFS") {
                    viewModel .runScheduling(runMode: runMode)
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
    FCFSView()
}
