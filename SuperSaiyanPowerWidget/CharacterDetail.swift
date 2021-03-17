//
//  CharacterDetail.swift
//  SuperSaiyanPowerWidgetExtension
//
//  Created by Daniel Ayala on 17/3/21.
//

import UIKit

struct CharacterDetail: Hashable, Identifiable {
    let name: String
    let avatar: String
    let level: Double
    let heroType: String
    let image: UIImage
    let bio: String
    
    var id: String {
        name
    }
    
    static let goku = CharacterDetail(
        name: "Goku",
        avatar: "☁️",
        level: 3,
        heroType: "Super Saiyan",
        image: UIImage(named: "goku_chilling")!,
        bio: "Power panda loves eating bamboo shoots and leaves.")
    
    static let vegeta = CharacterDetail(
        name: "Vegeta",
        avatar: "😎",
        level: 3,
        heroType: "Super Saiyan",
        image: UIImage(named: "")!,
        bio: "Power panda loves eating bamboo shoots and leaves.")
    
    static let trunks = CharacterDetail(
        name: "Trunks",
        avatar: "🦄",
        level: 3,
        heroType: "Super Saiyan",
        image: UIImage(named: "")!,
        bio: "Power panda loves eating bamboo shoots and leaves.")
    
    static let gohan = CharacterDetail(
        name: "Trunks",
        avatar: "🦄",
        level: 3,
        heroType: "Super Saiyan",
        image: UIImage(named: "")!,
        bio: "Power panda loves eating bamboo shoots and leaves.")
    
    static let availableCharacters = [goku, vegeta, trunks, gohan]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

