//
//  UIImageView+Ext.swift
//  StatesideTest
//
//  Created by Ernesto Gonzalez on 1/22/18.
//  Copyright © 2018 Ernesto Gonzalez. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage(withURL url: URL) {
        APIManager.share.getMemeImage(url: url) { image in
            guard let image = image else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
