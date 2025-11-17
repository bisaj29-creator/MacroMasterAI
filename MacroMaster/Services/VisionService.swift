import UIKit
import Vision
import CoreML

class VisionService {
    static let shared = VisionService()
    private init() {}
    
    func analyzeFood(image: UIImage) async -> (String, Int, Int, Int, Int) {
        if let key = KeychainHelper.shared.read(service: "MacroMaster", account: "openai_api_key"), !key.isEmpty {
            if let out = try? await analyzeWithOpenAI(image: image, apiKey: key) {
                return out
            }
        }
        if let out = analyzeWithCoreML(image: image) {
            return out
        }
        if let labelOut = ocrNutritionLabel(image: image) {
            return labelOut
        }
        return ("Unknown Meal", 0, 0, 0, 0)
    }

    private func analyzeWithOpenAI(image: UIImage, apiKey: String) async throws -> (String, Int, Int, Int, Int)? {
        guard let jpeg = image.jpegData(compressionQuality: 0.8) else { return nil }
        let b64 = jpeg.base64EncodedString()
        let prompt = "You are a nutrition model. Output ONLY JSON with fields: name, calories, protein, carbs, fat."
        let body: [String: Any] = [
            "model": "gpt-4o-mini",
            "input": [
                ["role": "user", "content": prompt],
                ["type": "input_image", "image_url": "data:image/jpeg;base64,\(b64)"]
            ]
        ]
        let url = URL(string: "https://api.openai.com/v1/responses")!
        var req = URLRequest(url: url)
        req.httpMethod = "POST"
        req.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.httpBody = try JSONSerialization.data(withJSONObject: body)
        let (data, resp) = try await URLSession.shared.data(for: req)
        if let http = resp as? HTTPURLResponse, http.statusCode == 200 {
            if let text = String(data: data, encoding: .utf8) {
                if let jsonRange = text.range(of: "\{.*\}", options: .regularExpression) {
                    let jsonStr = String(text[jsonRange])
                    if let jdata = jsonStr.data(using: .utf8) {
                        if let obj = try? JSONSerialization.jsonObject(with: jdata) as? [String: Any] {
                            let name = obj["name"] as? String ?? "Meal"
                            let calories = obj["calories"] as? Int ?? 0
                            let protein = obj["protein"] as? Int ?? 0
                            let carbs = obj["carbs"] as? Int ?? 0
                            let fat = obj["fat"] as? Int ?? 0
                            return (name, calories, protein, carbs, fat)
                        }
                    }
                }
            }
        }
        return nil
    }

    private func analyzeWithCoreML(image: UIImage) -> (String, Int, Int, Int, Int)? {
        return nil
    }

    private func ocrNutritionLabel(image: UIImage) -> (String, Int, Int, Int, Int)? {
        return nil
    }
}
