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
    let kiPower: Double
    let heroType: String
    let image: UIImage
    let bio: String
    
    var id: String {
        name
    }
    
    static let goku = CharacterDetail(
        name: "Goku",
        avatar: "☁️",
        kiPower: 1000,
        heroType: "Super Saiyan",
        image: UIImage(named: "goku_chilling")!,
        bio: "")
    
    static let vegeta = CharacterDetail(
        name: "Vegeta",
        avatar: "😎",
        kiPower: 999,
        heroType: "Super Saiyan",
        image: UIImage(named: "vegeta_chilling")!,
        bio: "")
    
    static let trunks = CharacterDetail(
        name: "Trunks",
        avatar: "🦄",
        kiPower: 800,
        heroType: "Super Saiyan",
        image: UIImage(named: "trunks_chilling")!,
        bio: "")
    
    static let gohan = CharacterDetail(
        name: "Gohan",
        avatar: "🧸",
        kiPower: 800,
        heroType: "Super Saiyan",
        image: UIImage(named: "gohan_chilling")!,
        bio: "")
    
    static let availableCharacters = [goku, vegeta, trunks, gohan]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func characterFromName(name: String?) -> CharacterDetail? {
        return (availableCharacters + superSaiyanCharacters).first(where: { (character) -> Bool in
            return character.name == name
        })
    }
    
//    var fullHealthDate: Date {
//        let healthNeeded = min(1 - healthLevel, 1)
//        let hoursUntilFullHealth = healthNeeded / healthRecoveryRatePerHour
//        let minutesUntilFullHealth = (hoursUntilFullHealth * 60)
//        let date = Calendar.current.date(byAdding: .minute, value: Int(minutesUntilFullHealth), to: Date())
//        
//        return date ?? Date()
//    }
}

extension CharacterDetail {
    static let superSaiyanGoku = CharacterDetail(
        name: "Goku",
        avatar: "☁️",
        kiPower: 5000,
        heroType: "Super Saiyan",
        image: UIImage(named: "goku_super_saiyan")!,
        bio: "")
    
    static let superSaiyanVegeta = CharacterDetail(
        name: "Vegeta",
        avatar: "😎",
        kiPower: 4000,
        heroType: "Super Saiyan",
        image: UIImage(named: "vegeta_super_saiyan")!,
        bio: "")
    
    static let superSaiyanTrunks = CharacterDetail(
        name: "Trunks",
        avatar: "🦄",
        kiPower: 3000,
        heroType: "Super Saiyan",
        image: UIImage(named: "trunks_super_saiyan")!,
        bio: "")
    
    static let superSaiyanGohan = CharacterDetail(
        name: "Gohan",
        avatar: "🧸",
        kiPower: 3500,
        heroType: "Super Saiyan",
        image: UIImage(named: "gohan_super_saiyan")!,
        bio: "")
    
    static let superSaiyanCharacters = [superSaiyanGoku, superSaiyanVegeta, superSaiyanTrunks, superSaiyanGohan]
}

