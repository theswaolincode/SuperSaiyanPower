//
//  CharacterDetail.swift
//  SuperSaiyanPowerWidgetExtension
//
//  Created by Daniel Ayala on 17/3/21.
//

import UIKit

struct CharacterDetail: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let avatar: String
    let kiPower: Double
    let heroType: String
    let image: UIImage
    let bio: String
    let url: URL
    
    static let goku = CharacterDetail(
        name: "Goku",
        avatar: "☁️",
        kiPower: 1000.0,
        heroType: "Super Saiyan",
        image: UIImage(named: "goku_chilling")!,
        bio: "(孫そん悟ご空くう Son Gokū), born Kakarot (カカロット Kakarotto), is the main protagonist of the Dragon Ball metaseries. Goku is a Saiyan originally sent to destroy Earth as an infant. However, a head injury at an early age alters his memory, ridding him of his initial destructive nature and allowing him to grow up to become one of Earth's greatest defenders. He constantly strives and trains to be the greatest warrior possible, which has kept the Earth and the universe safe from destruction many times.",
        url: URL(string: "game:///goku")!)
    
    static let vegeta = CharacterDetail(
        name: "Vegeta",
        avatar: "😎",
        kiPower: 999,
        heroType: "Super Saiyan",
        image: UIImage(named: "vegeta_chilling")!,
        bio: "(ベジータ Bejīta), more specifically Vegeta IV (ベジータ四世 Bejīta Yonsei)[6], recognized as Prince Vegeta (ベジータ王子 Bejīta Ōji) is the prince of the fallen Saiyan race and one of the main characters of the Dragon Ball series.Regal, egotistical, and full of pride, Vegeta was once a ruthless, cold-blooded warrior and outright killer,[7] but later abandons his role in the Frieza Force, instead opting to remain and live on Earth. His character evolves from villain, to anti-hero, then to hero through the course of the series, repeatedly fighting alongside the universe's most powerful warriors in order to protect his new home and surpass Goku in power",
        url: URL(string: "game:///vegeta")!)
    
    static let trunks = CharacterDetail(
        name: "Trunks",
        avatar: "🦄",
        kiPower: 800,
        heroType: "Super Saiyan",
        image: UIImage(named: "trunks_chilling")!,
        bio: "(トランクス Torankusu) is the Earthling and Saiyan hybrid son of Bulma and Vegeta, and the older brother of Bulla",
        url: URL(string: "game:///trunks")!)
    
    static let gohan = CharacterDetail(
        name: "Gohan",
        avatar: "🧸",
        kiPower: 800,
        heroType: "Super Saiyan",
        image: UIImage(named: "gohan_chilling")!,
        bio: "(孫そん悟ご飯はん Son Gohan) is a half-breed Saiyan and one of the most prominent characters in the Dragon Ball series. He is the elder son of the series' primary protagonist Goku and his wife Chi-Chi, the older brother of Goten, the husband of Videl and father to Pan. He is named after Goku's adoptive grandfather, Gohan.Unlike his father, Gohan lacks a passion for fighting (although, he does possess a strong power within him) and prefers to do so only when his loved ones are threatened.[6]  Nevertheless, Gohan fights alongside the Dragon Team in the defense of Earth for much of his life.",
        url: URL(string: "game:///gohan")!)
    
    static let availableCharacters = [goku, vegeta, trunks, gohan]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func characterFromName(name: String?) -> CharacterDetail? {
        return (availableCharacters + superSaiyanCharacters).first(where: { (character) -> Bool in
            return character.name == name
        })
    }
    
}

extension CharacterDetail {
    static let superSaiyanGoku = CharacterDetail(
        name: "Goku Super Saiyan 1st grade",
        avatar: "☁️",
        kiPower: 5000,
        heroType: "Super Saiyan",
        image: UIImage(named: "goku_super_saiyan")!,
        bio: "The regular Super Saiya-jin transformation. Goku first achieves it on Namek following Kuririn's death at the hands of Freeza, and all major Saiya-jin characters also achieve this transformation throughout the course of Z.",
        url: URL(string: "game:///superSaiyanGoku")!)
    
    static let superSaiyanVegeta = CharacterDetail(
        name: "Vegeta Super Saiyan 1st grade",
        avatar: "😎",
        kiPower: 4000,
        heroType: "Super Saiyan",
        image: UIImage(named: "vegeta_super_saiyan")!,
        bio: "The regular Super Saiya-jin transformation. Goku first achieves it on Namek following Kuririn's death at the hands of Freeza, and all major Saiya-jin characters also achieve this transformation throughout the course of Z.",
        url: URL(string: "game:///superSaiyanVegeta")!)
    
    static let superSaiyanTrunks = CharacterDetail(
        name: "Trunks Super Saiyan 1st grade",
        avatar: "🦄",
        kiPower: 3000,
        heroType: "Super Saiyan",
        image: UIImage(named: "trunks_super_saiyan")!,
        bio: "The regular Super Saiya-jin transformation. Goku first achieves it on Namek following Kuririn's death at the hands of Freeza, and all major Saiya-jin characters also achieve this transformation throughout the course of Z.",
        url: URL(string: "game:///superSaiyanTrunks")!)
    
    static let superSaiyanGohan = CharacterDetail(
        name: "Gohan Super Saiyan 1st grade",
        avatar: "🧸",
        kiPower: 3500,
        heroType: "Super Saiyan",
        image: UIImage(named: "gohan_super_saiyan")!,
        bio: "The regular Super Saiya-jin transformation. Goku first achieves it on Namek following Kuririn's death at the hands of Freeza, and all major Saiya-jin characters also achieve this transformation throughout the course of Z.",
        url: URL(string: "game:///superSaiyanGohan")!)
    
    static let superSaiyanCharacters = [superSaiyanGoku, superSaiyanVegeta, superSaiyanTrunks, superSaiyanGohan]
}

