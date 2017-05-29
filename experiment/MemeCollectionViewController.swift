//
//  MemeCollectionViewController.swift
//  Meme
//
//  Created by Tony Chen on 5/25/17.
//  Copyright © 2017 Tony Chen. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController{
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    var memes: [Memes]!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        print(memes.count)
        self.collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath.row)]
        
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailController.memes = self.memes[(indexPath.row)]
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fixflowLayout(size: view.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.fixflowLayout(size: size)
    }
    
    func fixflowLayout(size: CGSize){
        let space: CGFloat = 3.0
        let dimension: CGFloat
        
        if(size.width >= size.height){
            dimension = (size.width - (5 * space)) / 6.0
        }else{
            dimension = (size.width - (2 * space)) / 3.0
        }
        
        flowLayout?.minimumLineSpacing = space
        flowLayout?.minimumInteritemSpacing = space
        flowLayout?.itemSize = CGSize(width: dimension, height: dimension)
    }
    

    

   

}
