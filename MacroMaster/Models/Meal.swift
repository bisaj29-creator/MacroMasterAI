import Foundation

struct Meal: Codable, Identifiable {
    let id = UUID()
    let name: String
    let calories: Int
    let protein: Int
    let carbs: Int
    let fat: Int
    let date: Date
}
