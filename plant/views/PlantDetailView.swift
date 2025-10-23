import SwiftUI
import Foundation

struct PlantDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var reminders: [ReminderItem]
    @Binding var reminder: ReminderItem
    
    let lightOptions = ["Full sun", "Partial sun", "Shade"]
    let roomOptions = ["Kitchen", "Bedroom", "Living Room", "Office"]
    let amountOptions = ["20-50 ml", "50-100 ml", "100-200 ml"]
    let wateringDaysOptions = ["Every day", "Every 2 days", "Twice a week", "Once a week"]

    @State private var plantName: String
    @State private var selectedRoom: String
    @State private var selectedLight: String
    @State private var wateringDays: String // تم تعريفها هنا
    @State private var selectedWaterAmount: String
    
    @State private var showDeleteAlert = false
    
    init(reminders: Binding<[ReminderItem]>, reminder: Binding<ReminderItem>) {
        self._reminders = reminders
        self._reminder = reminder
        
        self._plantName = State(initialValue: reminder.wrappedValue.name)
        // تصحيح لاستخراج اسم الغرفة بدون "in "
        let roomName = reminder.wrappedValue.location.replacingOccurrences(of: "in ", with: "")
        self._selectedRoom = State(initialValue: roomName)
        self._selectedLight = State(initialValue: reminder.wrappedValue.light)
        // ✅ تصحيح: قراءة قيمة wateringDays من الكائن الحالي
        self._wateringDays = State(initialValue: reminder.wrappedValue.wateringDays)
        self._selectedWaterAmount = State(initialValue: reminder.wrappedValue.waterAmount)
    }

    func saveChanges() {
        if let index = reminders.firstIndex(where: { $0.id == reminder.id }) {
            reminders[index].name = plantName
            reminders[index].location = "in \(selectedRoom)"
            reminders[index].light = selectedLight
            reminders[index].waterAmount = selectedWaterAmount
            // تحديث خاصية wateringDays عند الحفظ
            reminders[index].wateringDays = wateringDays
        }
    }
    
    func deleteReminder() {
        reminders.removeAll { $0.id == reminder.id }
        dismiss()
    }
    
    var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
            
            Form {
                HStack {
                    Text("Plant Name").foregroundColor(.white)
                    Spacer()
                    TextField("Pothos", text: $plantName)
                        .multilineTextAlignment(.trailing)
                        .foregroundColor(.gray)
                }
                
                Section {
                    Picker(
                        selection: $selectedRoom,
                        label: HStack {
                            Image(systemName: "location").foregroundColor(.white)
                            Text("Room").foregroundColor(.white)
                        }
                    ) {
                        ForEach(roomOptions, id: \.self) { Text($0) }
                    }
                    
                    Picker(
                        selection: $selectedLight,
                        label: HStack {
                            Image(systemName: "sun.max").foregroundColor(.white)
                            Text("Light").foregroundColor(.white)
                        }
                    ) {
                        ForEach(lightOptions, id: \.self) { Text($0) }
                    }
                }
                
                Section {
                    Picker(
                        selection: $wateringDays,
                        label: HStack {
                            Image(systemName: "drop").foregroundColor(.white)
                            Text("Watering Days").foregroundColor(.white)
                        }
                    ) {
                        ForEach(wateringDaysOptions, id: \.self) { Text($0) }
                    }
                    
                    Picker(
                        selection: $selectedWaterAmount,
                        label: HStack {
                            Image(systemName: "drop").foregroundColor(.white)
                            Text("Water").foregroundColor(.white)
                        }
                    ) {
                        ForEach(amountOptions, id: \.self) { Text($0) }
                    }
                }
                
                Section {
                    Button("Delete Plant") {
                        deleteReminder()
                    }
                    .foregroundColor(.red)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            // زر الإغلاق (X)
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark")
                        .font(.title3.weight(.medium))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            ZStack {
                                Circle().fill(.ultraThinMaterial)
                                Circle().fill(Color("geeen1").opacity(0.4)) // لونك المخصص
                            }
                        )
                        .overlay(
                            Circle()
                                .stroke(Color("green1").opacity(0.8), lineWidth: 2)
                        )
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                }
            }
            
            // زر الحفظ (Checkmark)
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    saveChanges()
                    dismiss()
                }) {
                    Image(systemName: "checkmark")
                        .font(.title3.weight(.medium))
                        .foregroundColor(.white)
                        .padding(8)
                        .background(
                            ZStack {
                                Circle().fill(.ultraThinMaterial)
                                Circle().fill(Color("geeen1").opacity(0.4)) // لونك المخصص
                            }
                        )
                        .overlay(
                            Circle()
                                .stroke(Color("green1").opacity(0.8), lineWidth: 2)
                        )
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                }
            }
        }
    }
}


// ------------------------------------------
// ✅ تصحيح أخطاء الـ Preview
private struct PlantDetailViewPreviewContainer: View {
    // يجب تمرير قيمة لـ wateringDays لتجنب خطأ الاستدعاء
    @State private var dummyReminders: [ReminderItem] = [
        ReminderItem(name: "Pothos", location: "in Bedroom", light: "Full sun", waterAmount: "20-50 ml", wateringDays: "Every day")
    ]
    
    var body: some View {
        if let index = dummyReminders.indices.first {
            // ✅ تمرير الـ Binding بشكل سليم ($)
            PlantDetailView(reminders: $dummyReminders, reminder: $dummyReminders[index])
        } else {
            Text("No reminders")
        }
    }
}

#Preview {
    NavigationStack {
        PlantDetailViewPreviewContainer()
    }
}
