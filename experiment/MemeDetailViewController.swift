//
//  MemeDetailViewController.swift
//  Meme
//
//  Created by Tony Chen on 5/26/17.
//  Copyright © 2017 Tony Chen. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var memeImage: UIImageView!
    
    var memes: Memes!

    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memeImage.image = self.memes.memedImage
        
    }


}
