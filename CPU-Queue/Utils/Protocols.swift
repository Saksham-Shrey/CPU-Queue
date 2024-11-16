//
//  Protocols.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 16/11/24.
//

import Foundation

protocol SchedulingAlgorithm: ObservableObject {
    var processes: [Process] { get set }
    var ganttChartData: [GanttChartItem] { get set }
    var displayedProcesses: [GanttChartItem] { get set }
    var currentIndex: Int { get set }
    
    func fillRandomProcesses(count: Int)
    func runScheduling(runMode: RunMode)
    func startGanttChartTimer()
    func showNextGanttItem()
    func showPreviousGanttItem()
    func reset()
}
