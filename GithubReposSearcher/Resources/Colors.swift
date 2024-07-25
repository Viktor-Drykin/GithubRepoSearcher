//
//  Colors.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import UIKit

enum Colors {
    static let navigationBarTitle = UIColor(rgb: 0x06375A)
    static let sectionHeader = UIColor(rgb: 0x006AB7)
    static let title = UIColor(rgb: 0x006AB7)
    static let subtitle = UIColor(rgb: 0x00487C)
    static let background = UIColor(rgb: 0xD6EEFF)
}


extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
