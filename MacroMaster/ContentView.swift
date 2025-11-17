import SwiftUI

struct ContentView: View {
    @State private var showCamera = false
    @State private var image: UIImage?
    @State private var meals: [Meal] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack(spacing: 18) {
                    Spacer().frame(height: 12)
                    if let img = image {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 260)
                            .cornerRadius(14)
                            .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.gray.opacity(0.2)))
                    } else {
                        Image("AppIcon")
                            .resizable()
                            .frame(width: 140, height: 140)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(radius: 10)
                    }
                    
                    Text("Macro Master")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                    
                    Text("Take a photo of your meal and Macro Master will estimate calories & macros.")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    HStack(spacing: 12) {
                        Button(action: { showCamera = true }) {
                            Label("Take Photo", systemImage: "camera.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.pink]), startPoint: .leading, endPoint: .trailing))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        
                        NavigationLink(destination: LogView(meals: meals)) {
                            Label("Log", systemImage: "list.bullet")
                                .frame(width: 90)
                                .padding()
                                .background(Color(.systemGray6).opacity(0.06))
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showCamera) {
                CameraView(meals: $meals, image: $image)
            }
        }
    }
}
