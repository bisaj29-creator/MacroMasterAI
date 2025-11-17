import SwiftUI

struct LogView: View {
    let meals: [Meal]
    var body: some View {
        List(meals, id: \ .name) { meal in
            VStack(alignment: .leading) {
                Text(meal.name).font(.headline)
                Text("Calories: \(meal.calories) • P:\(meal.protein)g C:\(meal.carbs)g F:\(meal.fat)g")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }.padding(.vertical, 6)
        }
        .navigationTitle("Meal Log")
    }
}
