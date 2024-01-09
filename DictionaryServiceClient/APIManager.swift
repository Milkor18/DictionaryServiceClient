import Foundation


class APIManager {
    let baseURL: String = "https://nlp-translation.p.rapidapi.com/v1/translate"
    
    
}

// MARK: - TranslateResponse
struct TranslateResponse: Codable {
    let from: String
    let originalText: String
    let to: String
    let translatedCharacters: Int
    let translatedText: TranslatedText

    enum CodingKeys: String, CodingKey {
        case from
        case originalText = "original_text"
        case to
        case translatedCharacters = "translated_characters"
        case translatedText = "translated_text"
    }
}

// MARK: - TranslatedText
struct TranslatedText: Codable {
    let es: String?
    let nso: String?
    let zu: String?
    let ms: String?
    let id: String?
    let tn: String?
    let ro: String?
    let de: String?
    let pt: String?
}
