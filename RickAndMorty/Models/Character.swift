//
//  Character.swift
//  RickAndMorty
//
//  Created by Aleksei Voronovskii on 1/26/23.
//

struct Character: Decodable {
    let id: Int?
    let name: String?
    let gender: String?
    let origin: OriginLocation?
    let image: String?
    
    init(characterData: [String: Any]) {
        id = characterData["id"] as? Int
        name = characterData["name"] as? String
        gender = characterData["gender"] as? String
        origin = OriginLocation(value: characterData)
        image = characterData["image"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersData = value as? [[String: Any]] else { return [] }
        return charactersData.compactMap { Character(characterData: $0) }
    }
}

struct OriginLocation: Decodable {
    let name: String
    
    init(value: [String: Any]) {
        let origin = value["origin"] as? [String: String]
        name = origin?["name"] ?? ""
    }
}
