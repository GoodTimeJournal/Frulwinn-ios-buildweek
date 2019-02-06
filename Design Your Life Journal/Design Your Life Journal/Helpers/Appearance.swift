//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

enum Appearance {
    
    static func montserratBoldFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Montserrat-Bold", size: pointSize) else { fatalError("Font is nil. Check the name of the font.") }
        return UIFontMetrics(forTextStyle: .callout).scaledFont(for: font)
    }
    
    static func montserratRegularFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Montserrat-Regular", size: pointSize) else { fatalError("Font is nil. Check the name of the font.") }
        return UIFontMetrics(forTextStyle: .callout).scaledFont(for: font)
    }
    
    static func setAppearance() {
        //navigationbar
        
        UINavigationBar.appearance().barTintColor = .lightGray
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Montserrat-Regular", size: 30)!]
        
        //bar button item
        UIBarButtonItem.appearance().tintColor = .gray
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 14)!, NSAttributedString.Key.foregroundColor : UIColor.gray], for: .normal)
        
        //labels
        UILabel.appearance().textColor = .gray
        UILabel.appearance().font = UIFont(name: "Montserrat-Regular", size: 16)
        
    }
  
}
