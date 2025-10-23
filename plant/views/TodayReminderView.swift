// في ملف TodayReminderView.swift
internal import SwiftUI
import Foundation

struct TodayReminderView: View {
    
  
    @ObservedObject var viewModel: ReminderListViewModel
    
    @State private var isShowingSheet: Bool = false
    @State private var selectedReminderIndex: Int? = nil
    
    var allRemindersCompleted: Bool {
        if viewModel.reminders.isEmpty { return false }
        return viewModel.reminders.allSatisfy { $0.isChecked }
    }
    
    var body: some View {
        let completed = allRemindersCompleted
        
        NavigationStack {
            ZStack {
                Color.clear.edgesIgnoringSafeArea(.all)
                
                if completed {
                
                    Text("All reminders completed! 🎉")
                        .font(.title)
                        .foregroundColor(.white)
                } else {
                    VStack(spacing: 0) {
                        
                        GeometryReader { geo in
                            Rectangle()
                                .fill(Color.geeen1)
                                .frame(width: geo.size.width * CGFloat(viewModel.progressAmount), height: 6)
                        }
                        .frame(height: 6)
                        
                        Spacer().frame(height: 15)
                        
                        List {
                            
                            Section {
                                Text(viewModel.headerText)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                            }
                            
                            Section {
                                ForEach(viewModel.reminders) { item in
                                    Button {
                                        if let idx = viewModel.reminders.firstIndex(where: { $0.id == item.id }) {
                                            selectedReminderIndex = idx
                                        }
                                    } label: {
                                        ReminderListItem(
                                            item: item,
                                            toggleAction: {
                                                viewModel.toggleCheckmark(for: item)
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
                                .onDelete(perform: viewModel.deleteReminder)
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
                SetReminderView(onSave: viewModel.addReminder, shouldNavigateToTodayView: .constant(false))
            }
            .sheet(isPresented: Binding<Bool>(
                get: { selectedReminderIndex != nil },
                set: { newValue in
                    if !newValue { selectedReminderIndex = nil }
                })
            ) {
                if let idx = selectedReminderIndex, idx < viewModel.reminders.count {
                    PlantDetailView(reminders: $viewModel.reminders, reminder: $viewModel.reminders[idx])
                } else {
                    Text("No item")
                }
            }
        }
    }
}

// Preview يحتاج لتعديل لاستخدام ViewModel
struct TodayReminderView_Previews: PreviewProvider {
    static var previews: some View {
        TodayReminderView(viewModel: ReminderListViewModel())
    }
}
