import SwiftUI


struct ContentView: View {
    
    @State private var reminders: [ReminderItem] = []
    @State private var isShowingSetReminderSheet = false
    @State private var navigateToTodayView = false
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Color.clear.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center, spacing: 0) {
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("My Plants 🌱")
                            .font(.largeTitle).fontWeight(.bold).foregroundColor(.white)
                            .padding(.horizontal).padding(.top, 50)
                        Rectangle().fill(Color(white: 0.2)).frame(height: 1).padding(.top, 10)
                    }
                    
                    Spacer()
                    
                    Image("plant1")
                        .padding(.bottom, 50)
                    
                    Button {
                        isShowingSetReminderSheet = true
                    } label: {
                        Text("Set Plant Reminder")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 60)
                            .background(
                                Capsule()
                                    .fill(Color.geeen1)
                            )
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $isShowingSetReminderSheet) {
                        
                        SetReminderView(
                            reminders: $reminders,
shouldNavigateToTodayView: $navigateToTodayView
                        )
                    }
                    
                    Spacer().frame(height: 200)
                    
                }
            }
            .navigationDestination(isPresented: $navigateToTodayView) {
                TodayReminderView(reminders: $reminders)
            }
        }
    }
}

#Preview {
    ContentView()
}
