import SwiftUI

struct LogView: View {
    let meals: [Meal]
    var body: some View {
        List {
            ForEach(meals) { meal in
                VStack(alignment: .leading) {
                    Text(meal.name).font(.headline).foregroundColor(.white)
                    Text("Calories: \(meal.calories) • P:\(meal.protein)g C:\(meal.carbs)g F:\(meal.fat)g")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }.padding(.vertical, 6)
            }
        }
        .listStyle(.insetGrouped)
        .background(Color.black)
        .navigationTitle("Meal Log")
    }
}
