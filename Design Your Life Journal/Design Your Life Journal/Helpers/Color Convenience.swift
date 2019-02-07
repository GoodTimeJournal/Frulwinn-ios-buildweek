//  Copyright © 2019 Frulwinn. All rights reserved.

import UIKit

extension UIColor {
    convenience init (_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    static let lightGray = UIColor(233, 233, 233, 1)
    static let gray = UIColor(199, 199, 199, 1)
    static let skyBlue = UIColor(4, 108, 201, 1)
    
}
