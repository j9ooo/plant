internal import SwiftUI
import Foundation

struct StarterView: View {
    
    // If you don't need to keep a local list, you can remove this entirely.
    // @State private var starterReminders: [ReminderItem] = []
    
    @State private var isShowingSetReminderSheet = false
    @State private var navigateToTodayView = false
    
    // Provide the view model that TodayReminderView expects
    @StateObject private var viewModel = ReminderListViewModel()
    
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
                    
                    Image("plant3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                        .padding(.bottom, 190)
                    
                    Button(action: {
                        isShowingSetReminderSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            // If you don't have a Color extension for .geeen1, replace with Color("geeen1")
                            .background(Color("geeen1"))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            .padding(.trailing, -290)
                            .padding(.vertical, 40)
                            .padding(.leading,190)
                    }
                    .buttonStyle(.plain)
                }
            }
            .preferredColorScheme(.dark)
            
            NavigationLink(destination: TodayReminderView(viewModel: viewModel)) {
                // You can add a visible label here if desired
                EmptyView()
            }
            .hidden() // Keep it hidden if you only navigate programmatically
            
            .sheet(isPresented: $isShowingSetReminderSheet) {
                SetReminderView(
                    onSave: { newItem in
                        viewModel.addReminder(newItem)
                    },
                    shouldNavigateToTodayView: $navigateToTodayView
                )
            }
        }
    }
}

#Preview {
    StarterView()
}
