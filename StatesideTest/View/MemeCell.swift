//
//  MemeCell.swift
//  StatesideTest
//
//  Created by Ernesto Gonzalez on 1/22/18.
//  Copyright © 2018 Ernesto Gonzalez. All rights reserved.
//

import UIKit

class MemeCell: UITableViewCell, NibLoadableView {

    @IBOutlet weak var memeImg: UIImageView!
    @IBOutlet weak var memeNameLbl: UILabel!

    func configureCell(withMeme meme: Meme) {
        self.memeImg.loadImage(withURL: URL(string: meme.imageUrl)!)
        self.memeNameLbl.text = meme.displayName
    }
}
