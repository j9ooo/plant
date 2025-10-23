import SwiftUI
import Foundation

struct InfoCapsule: View {
    let text: String
    let icon: String
    let textColor: Color
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon).font(.caption2).foregroundColor(textColor)
            Text(text).font(.caption).foregroundColor(textColor)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Capsule().fill(.ultraThinMaterial))
    }
}

struct ReminderListItem: View {
    let item: ReminderItem
    let toggleAction: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            Button(action: toggleAction) {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isChecked ? .green : .gray)
                    .font(.title3)
                    .padding(8)
                    .accessibilityLabel(item.isChecked ? "Marked as done" : "Mark as done")
            }
            .buttonStyle(.borderless)
            .contentShape(Rectangle())
            
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "location").font(.caption).foregroundColor(.gray)
                    Text(item.location).font(.caption).foregroundColor(.gray)
                }
                Text(item.name).font(.headline).foregroundColor(.white)
                HStack(spacing: 8) {
                    InfoCapsule(text: item.light, icon: "sun.max", textColor: Color.yellow)
                    InfoCapsule(text: item.waterAmount, icon: "drop", textColor: Color.cyan)
                }
            }
            .padding(.vertical, 8)
            
            Spacer()
        }
    }
}

struct TodayReminderView: View {
    
    @Binding var reminders: [ReminderItem]
    
    @State private var isShowingSheet: Bool = false
    @State private var selectedReminderIndex: Int? = nil
    
    var progressAmount: Double {
        reminders.isEmpty ? 0.0 : Double(reminders.filter { $0.isChecked }.count) / Double(reminders.count)
    }
    
    var headerText: String {
        let checkedCount = reminders.filter { $0.isChecked }.count
        let totalCount = reminders.count
        
        if totalCount == 0 {
            return "Add your first plant to get started! 🌱"
        } else if checkedCount == 0 {
            return "Your plants are waiting for a sip. 💦"
        } else {
            return "\(checkedCount) of your plants feel loved today ✨"
        }
    }
    
    func deleteItems(at offsets: IndexSet) { reminders.remove(atOffsets: offsets) }
    
    var allRemindersCompleted: Bool {
        if reminders.isEmpty { return false }
        return reminders.allSatisfy { $0.isChecked }
    }
    
    var body: some View {
        let completed = allRemindersCompleted
        
        NavigationStack {
            ZStack {
                Color.clear.edgesIgnoringSafeArea(.all)
                
                if completed {
                    StarterView()
                } else {
                    VStack(spacing: 0) {
                        
                        GeometryReader { geo in
                            Rectangle()
                                .fill(Color.geeen1)
                                .frame(width: geo.size.width * CGFloat(progressAmount), height: 6)
                        }
                        .frame(height: 6)
                        
                        Spacer().frame(height: 15)
                        
                        List {
                            
                            Section {
                                Text(headerText)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                            }
                            
                            Section {
                                ForEach(reminders.indices, id: \.self) { index in
                                    let item = reminders[index]
                                    Button {
                                        selectedReminderIndex = index
                                    } label: {
                                        ReminderListItem(
                                            item: item,
                                            toggleAction: {
                                                reminders[index].isChecked.toggle()
                                            }
                                        )
                                        .padding(.horizontal, 15)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(.ultraThinMaterial)
                                        )
                                    }
                                    .buttonStyle(.plain)
                                    .listRowBackground(Color.clear)
                                    .listRowInsets(EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 10))
                                    .listRowSeparator(.hidden)
                                }
                                .onDelete(perform: deleteItems)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal, -20)
                    }
                    .navigationTitle("My Plants 🌱")
                    .navigationBarTitleDisplayMode(.large)
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: { isShowingSheet = true }) {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 56, height: 56)
                                    .background(Color.geeen1)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .padding(.trailing, 20)
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
            .sheet(isPresented: $isShowingSheet) {
                SetReminderView(reminders: $reminders, shouldNavigateToTodayView: .constant(false))
            }
            .sheet(isPresented: Binding<Bool>(
                get: { selectedReminderIndex != nil },
                set: { newValue in
                    if !newValue { selectedReminderIndex = nil }
                })
            ) {
                if let idx = selectedReminderIndex, idx < reminders.count {
                    PlantDetailView(reminders: $reminders, reminder: $reminders[idx])
                } else {
                    Text("No item")
                }
            }
        }
    }
}


    
    // الكود المصحح في TodayReminderView.swift

    struct TodayReminderView_Previews: PreviewProvider {
        
        @State static var dummyReminders = [
            // ✅ تم إضافة wateringDays:
            ReminderItem(name: "Monstera", location: "in Kitchen", light: "Full sun", waterAmount: "20-50 ml", wateringDays: "Every day"),
            ReminderItem(name: "Pothos", location: "in Bedroom", light: "Full sun", waterAmount: "20-50 ml", wateringDays: "Once a week"),
            ReminderItem(name: "Orchid", location: "in Living Room", light: "Full sun", waterAmount: "20-50 ml", wateringDays: "Twice a week"),
            ReminderItem(name: "Spider", location: "in Kitchen", light: "Full sun", waterAmount: "20-50 ml", wateringDays: "Every 2 days")
        ]
        
        static var previews: some View {
            TodayReminderView(reminders: $dummyReminders)
        }
    }
    

