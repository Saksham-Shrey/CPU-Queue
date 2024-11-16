//
//  GanttChartItem.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 16/11/24.
//


struct GanttChartItem: Identifiable {
    var id: Int
    var processId: Int
    var startTime: Int
    var endTime: Int
    var duration: Int
}
