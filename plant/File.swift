//
//  File.swift
//  plant
//
//  Created by Jumanah aldowaish on 30/04/1447 AH.
//

import Foundation

import SwiftUI

struct ReminderItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var location: String
    var light: String
    var waterAmount: String
    // الخصائص الجديدة
    var wateringDays: String
    var lastWateredDate: Date = Date()
    
    var isChecked: Bool = false
}
