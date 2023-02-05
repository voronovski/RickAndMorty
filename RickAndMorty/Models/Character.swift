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
//    let origin: Origin?
    let image: String?
    
    init(characterData: [String: Any]) {
        id = characterData["id"] as? Int
        name = characterData["name"] as? String
        gender = characterData["gender"] as? String
    //  origin = character["origin"] as? Origin
        image = characterData["image"] as? String
    }
    
    static func getCharacters(from value: Any) -> [Character] {
        guard let charactersData = value as? [[String: Any]] else { return [] }
        return charactersData.compactMap { Character(characterData: $0) }
    }
}

//struct Origin: Decodable {
//    let name: String
//}

