//
//  StorageManager.swift
//  SuperSaiyanPower
//
//  Created by Daniel Ayala on 6/4/21.
//

import Foundation


class StorageManager {
    internal let userDefaultsGroups: UserDefaults = UserDefaults(suiteName: "group.com.interactivedreams.SuperSaiyanPower") ?? UserDefaults.standard

    internal func saveValue<T>(_ value: T, forKey key: String) where T: Encodable {
        if let encoder = try? JSONEncoder().encode(value) {
            userDefaultsGroups.setValue(encoder, forKey: key)
            userDefaultsGroups.synchronize()
        }
    }

    internal func getValueForKey<T>(_ key: String) -> T? where T: Decodable {
        if let data = userDefaultsGroups.object(forKey: key) as? Data,
           let decodable = try? JSONDecoder().decode(T.self, from: data) {
            return decodable
        }

        return nil
    }

    internal func removeValueForKey(_ key: String) {
        userDefaultsGroups.removeObject(forKey: key)
        userDefaultsGroups.synchronize()
    }
}
