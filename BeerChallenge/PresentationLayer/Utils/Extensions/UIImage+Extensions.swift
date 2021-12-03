//
//  UIImage+Extensions.swift
//  BeerChallenge
//
//  Created by Josseph Colonia on 2/12/21.
//

import UIKit

extension UIImage {
    func resizeImage(scale: CGFloat) -> UIImage? {
        let newSize = CGSize(width: size.width * scale, height: size.height * scale)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContext(newSize)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
