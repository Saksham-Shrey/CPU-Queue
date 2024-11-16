//
//  Process.swift
//  CPU-Queue
//
//  Created by Saksham Shrey on 15/11/24.
//

struct Process: Identifiable {
    var id: Int
    var arrivalTime: Int
    var burstTime: Int
    
    var completionTime: Int?
    var turnAroundTime: Int?
    var waitingTime: Int?
    
    var priority: Int?
}
