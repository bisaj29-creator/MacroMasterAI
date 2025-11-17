import SwiftUI

struct ContentView: View {
    @State private var showCamera = false
    @State private var image: UIImage?
    @State private var meals: [Meal] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if let img = image {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 260)
                        .cornerRadius(12)
                } else {
                    Image("AppIcon")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .padding(.top, 24)
                }
                
                Text("Welcome to Macro Master")
                    .font(.title2)
                    .bold()
                
                Text("Take a photo of your meal to estimate calories & macros.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                HStack {
                    Button(action: { showCamera = true }) {
                        Label("Take Photo", systemImage: "camera")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                NavigationLink(destination: LogView(meals: meals)) {
                    Text("View Log")
                        .padding()
                }
                
                Spacer()
            }
            .navigationTitle("Macro Master")
            .sheet(isPresented: $showCamera) {
                CameraView(meals: $meals, image: $image)
            }
        }
    }
}
