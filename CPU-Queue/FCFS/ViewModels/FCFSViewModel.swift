//
//  FCFSViewModel.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 15/11/24.
//

import SwiftUI

class FCFSViewModel: ObservableObject, SchedulingAlgorithm {
    @Published var processes: [Process] = []
    @Published var ganttChartData: [GanttChartItem] = []
    @Published var displayedProcesses: [GanttChartItem] = []
    @Published var currentIndex: Int = 0

    private var timer: Timer?

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
        reset()

        // Sort processes by Arrival Time
        processes.sort(by: { $0.arrivalTime < $1.arrivalTime })

        var currentTime = 0
        for process in processes {
            let startTime = max(currentTime, process.arrivalTime)
            let endTime = startTime + process.burstTime

            if let index = processes.firstIndex(where: { $0.id == process.id }) {
                processes[index].completionTime = endTime
                processes[index].turnAroundTime = endTime - processes[index].arrivalTime
                processes[index].waitingTime = processes[index].turnAroundTime! - processes[index].burstTime
            }

            ganttChartData.append(GanttChartItem(
                id: process.id,
                processId: process.id,
                startTime: startTime,
                endTime: endTime,
                duration: process.burstTime
            ))

            currentTime = endTime
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
