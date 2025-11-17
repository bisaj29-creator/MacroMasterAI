import SwiftUI
import UIKit

struct CameraView: UIViewControllerRepresentable {
    @Binding var meals: [Meal]
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    func makeCoordinator() -> Coordinator { Coordinator(self) }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView
        init(_ parent: CameraView) { self.parent = parent }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true)
            if let img = info[.originalImage] as? UIImage {
                parent.image = img
                Task {
                    let (name, calories, protein, carbs, fat) = await VisionService.shared.analyzeFood(image: img)
                    let meal = Meal(name: name, calories: calories, protein: protein, carbs: carbs, fat: fat, date: Date())
                    MealStore.shared.saveMeal(meal)
                    DispatchQueue.main.async {
                        parent.meals.append(meal)
                    }
                }
            }
        }
    }
}
