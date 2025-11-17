import Foundation

class MealStore {
    static let shared = MealStore()
    private let file = "meals.json"
    func documentsURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    func saveMeal(_ meal: Meal) {
        var meals = loadMeals()
        meals.append(meal)
        do {
            let data = try JSONEncoder().encode(meals)
            try data.write(to: documentsURL().appendingPathComponent(file))
        } catch {
            print("Error saving meal: \(error)")
        }
    }
    func loadMeals() -> [Meal] {
        do {
            let url = documentsURL().appendingPathComponent(file)
            if FileManager.default.fileExists(atPath: url.path) {
                let data = try Data(contentsOf: url)
                let meals = try JSONDecoder().decode([Meal].self, from: data)
                return meals
            }
        } catch {
            print("Error loading meals: \(error)")
        }
        return []
    }
}
