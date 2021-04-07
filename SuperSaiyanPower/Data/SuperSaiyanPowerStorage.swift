//
//  SuperSaiyanPowerStorage.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 7/4/21.
//

import Foundation

class SuperSaiyanPowerStorage: StorageManager {
    private let kSuperSaiyanPowerActivated = "SuperSaiyanPowerActivated"

    func saveSuperSaiyanActivation(active: Bool) {
        saveValue(active, forKey: kSuperSaiyanPowerActivated)
    }

    func getSuperSaiyanActivation() -> Bool? {
        return getValueForKey(kSuperSaiyanPowerActivated)
    }

}
