//
//  RoundRobinViewModel.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 16/11/24.
//

import SwiftUI

class RoundRobinViewModel: ObservableObject, SchedulingAlgorithm {

    @Published var processes: [Process] = []
    @Published var ganttChartData: [GanttChartItem] = []
    @Published var displayedProcesses: [GanttChartItem] = []
    @Published var currentIndex: Int = 0

    private var timer: Timer?
    private var quantum: Int = 2

    func fillRandomProcesses(count: Int = Int.random(in: 1...10)) {
        processes = (1...count).map {
            Process(
                id: $0,
                arrivalTime: Int.random(in: 0...10),
                burstTime: Int.random(in: 1...20)
            )
        }
    }
    

    func runScheduling(runMode: RunMode) {
        print("Run")
    }
    
    func runScheduling(runMode: RunMode, quantum: Int) {
        guard quantum > 0 else {
            print("Quantum must be greater than 0")
            return
        }

        reset()

        var time = 0
        var remainingBursts = processes.map { $0.burstTime }
        var queue: [Int] = []

        // Sort processes by arrival time
        processes.sort(by: { $0.arrivalTime < $1.arrivalTime })

        // Add processes that are available at the start
        queue += processes.enumerated().filter { $0.element.arrivalTime <= time }.map { $0.offset }

        while !queue.isEmpty || processes.contains(where: { $0.arrivalTime > time && remainingBursts[$0.id - 1] > 0 }) {
            if queue.isEmpty {
                // Advance time to the next process arrival if the queue is empty
                time = processes.first(where: { $0.arrivalTime > time })?.arrivalTime ?? time
                queue += processes.enumerated().filter { $0.element.arrivalTime <= time && remainingBursts[$0.offset] > 0 }.map { $0.offset }
            }

            guard let index = queue.first else { break }
            queue.removeFirst()

            let process = processes[index]

            if remainingBursts[index] > 0 {
                // Calculate execution time and update time
                let executionTime = min(remainingBursts[index], quantum)
                remainingBursts[index] -= executionTime
                let previousTime = time
                time += executionTime

                ganttChartData.append(GanttChartItem(
                    id: process.id,
                    processId: process.id,
                    startTime: previousTime,
                    endTime: time,
                    duration: executionTime
                ))

                // Add processes that arrived during this execution
                queue += processes.enumerated()
                    .filter { $0.offset != index && $0.element.arrivalTime > previousTime && $0.element.arrivalTime <= time }
                    .map { $0.offset }

                // Requeue the current process if it has remaining burst time
                if remainingBursts[index] > 0 {
                    queue.append(index)
                } else {
                    // Update process metrics if completed
                    processes[index].completionTime = time
                    processes[index].turnAroundTime = time - process.arrivalTime
                    processes[index].waitingTime = max(0, processes[index].turnAroundTime! - process.burstTime)
                }
            }
        }

        if runMode == .automatic {
            startGanttChartTimer()
        } else if !ganttChartData.isEmpty {
            displayedProcesses = [ganttChartData[0]]
        }
    }



    
    func startGanttChartTimer() {
        timer?.invalidate()
        currentIndex = 0
        displayedProcesses = []

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, self.currentIndex < self.ganttChartData.count else {
                self?.timer?.invalidate()
                return
            }

            self.displayedProcesses.append(self.ganttChartData[self.currentIndex])
            self.currentIndex += 1
        }
    }

    func showNextGanttItem() {
        guard currentIndex < ganttChartData.count - 1 else { return }
        currentIndex += 1
        displayedProcesses.append(ganttChartData[currentIndex])
    }

    func showPreviousGanttItem() {
        guard currentIndex > 0 else { return }
        displayedProcesses.removeLast()
        currentIndex -= 1
    }

    func reset() {
        ganttChartData = []
        displayedProcesses = []
        timer?.invalidate()
        currentIndex = 0
    }
}
