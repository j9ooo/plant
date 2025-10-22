//
//  SetReminderView.swift
//  plant
//
//  Created by Jumanah aldowaish on 30/04/1447 AH.
//

import Foundation
import SwiftUI
import Foundation

// 🛑 تم حذف تعريف ReminderItem الذي كان متداخلاً

struct SetReminderView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var reminders: [ReminderItem]
    @Binding var shouldNavigateToTodayView: Bool

    let lightOptions = ["Full sun", "Partial sun", "Shade"]
    let roomOptions = ["Kitchen", "Bedroom", "Living Room", "Office"]
    let amountOptions = ["20-50 ml", "50-100 ml", "100-200 ml"]
    let wateringDaysOptions = ["Every day", "Every 2 days", "Twice a week", "Once a week"]

    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full sun"
    @State private var wateringDays: String = "Every day"
    @State private var selectedWaterAmount: String = "20-50 ml"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear.edgesIgnoringSafeArea(.all)
                
                Form {
                    HStack {
                        Text("Plant Name").foregroundColor(.white)
                        Spacer()
                        TextField("Pothos", text: $plantName)
                            .multilineTextAlignment(.trailing).foregroundColor(.gray)
                    }
                    
                    Section {
                        Picker(selection: $selectedRoom, label: HStack { Image(systemName: "location").foregroundColor(.white); Text("Room").foregroundColor(.white) }) { ForEach(roomOptions, id: \.self) { Text($0) } }
                        Picker(selection: $selectedLight, label: HStack { Image(systemName: "sun.max").foregroundColor(.white); Text("Light").foregroundColor(.white) }) { ForEach(lightOptions, id: \.self) { Text($0) } }
                    }
                    
                    Section {
                        Picker(selection: $wateringDays, label: HStack { Image(systemName: "drop").foregroundColor(.white); Text("Watering Days").foregroundColor(.white) }) { ForEach(wateringDaysOptions, id: \.self) { Text($0) } }
                        Picker(selection: $selectedWaterAmount, label: HStack { Image(systemName: "drop").foregroundColor(.white); Text("Water").foregroundColor(.white) }) { ForEach(amountOptions, id: \.self) { Text($0) } }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Set Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: { dismiss() }) { Image(systemName: "xmark").font(.title3.weight(.medium))
                            .padding(4)
                        .foregroundColor(.white) }
                    ZStack {
                        Circle()
                            .fill(.ultraThinMaterial) // المادة الزجاجية الأساسية
                        Circle()
                            .fill(Color("geeen1").opacity(0.5)) // طبقة اللون المخصص بشفافية
                        
                        .overlay(
                            Circle()
                                .stroke(Color("green1").opacity(0.8), lineWidth: 2) // الإطار
                        )
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if !plantName.isEmpty {
                            let newReminder = ReminderItem(
                                name: plantName, location: "in \(selectedRoom)", light: selectedLight,
                                waterAmount: selectedWaterAmount, isChecked: false
                            )
                            reminders.append(newReminder)
                        }
                        
                        dismiss()
                        shouldNavigateToTodayView = true
                        
                    }) {
                        Image(systemName: "checkmark").font(.title3.weight(.medium))
                            .foregroundColor(.white)
                            .padding(5)
                            .background(Color.geeen1)
                            .clipShape(Circle())
                            .background(
                                ZStack {
//                                    Circle()
//                                        .fill(.ultraThinMaterial)
//                                    Circle()
//                                       .fill(Color("geeen1").opacity(0.5))
                                }
                            )
                            .overlay(
                                Circle()
                                 .stroke(Color("green1").opacity(0.8), lineWidth: 2)
                            )
                            .shadow(radius: 5)
                    }
                                                                            }
                    }
                }
            }
//            .preferredColorScheme(.dark)
        }
    


#Preview {
    SetReminderView(reminders: .constant([]), shouldNavigateToTodayView: .constant(false))
}
