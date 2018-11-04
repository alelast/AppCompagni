//
//  SeatsController.swift
//  AppCompagniBanco
//
//  Created by Alessio Lasta on 18/10/18.
//  Copyright © 2018 Alessio Lasta. All rights reserved.
//

import UIKit

class SeatsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeatsCollectionViewCell.kidentifier, for: indexPath) as! SeatsCollectionViewCell

        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

 

}
