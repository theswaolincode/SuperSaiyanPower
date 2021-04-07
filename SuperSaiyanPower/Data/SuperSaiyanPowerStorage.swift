//
//  SuperSaiyanPowerStorage.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 7/4/21.
//

import Foundation

class SuperSaiyanPowerStorage: StorageManager {
    private let kSuperSaiyanPowerActivated = "SuperSaiyanPowerActivated"

    func saveSuperSaiyanActiveState(isActive: Bool) {
        saveValue(isActive, forKey: kSuperSaiyanPowerActivated)
    }

    func getSuperSaiyanActiveState() -> Bool? {
        return getValueForKey(kSuperSaiyanPowerActivated)
    }

}
