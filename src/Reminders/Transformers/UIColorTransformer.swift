//
//  UIColorTransformer.swift
//  Reminders
//
//  Created by Nayan on 18/05/25.
//

import Foundation
import UIKit

class UIColorTransformer: ValueTransformer {
    
    // Serializes the color that's passed in
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else { return nil }
        
        do {
            let data = try NSKeyedArchiver.archivedData(
                withRootObject: color,
                requiringSecureCoding: true,
            )
            return data
        } catch {
            return nil
        }
    }
    
    // Deserializes the color that's retrieved out
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        
        do {
            let color = try NSKeyedUnarchiver.unarchivedObject(
                ofClass: UIColor.self,
                from: data,
            )
            return color
        } catch {
            return nil
        }
    }
}
