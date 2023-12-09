//
//  UIImageExtension.swift
//
//
//  Created by Jean paul on 2023-12-08.
//

import SwiftUI

#if DEBUG
    extension UIImage {
        static func createImage(withColor color: UIColor = .green) -> UIImage {
            let size = CGSize(width: 100, height: 100)
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

            let context = UIGraphicsGetCurrentContext()!
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: CGPoint.zero, size: size))

            let image = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            return image
        }
    }
#endif
