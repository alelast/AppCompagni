//
//  ListaCompagniCell.swift
//  LoginxCasa
//
//  Created by Valerio Ly on 17/10/18.
//  Copyright © 2018 Valerio Ly. All rights reserved.
//

import UIKit

class ListaCompagniCell: UITableViewCell {

    
    @IBOutlet weak var Img: UIButton!
    
    @IBOutlet weak var NameLabel: UILabel! {
        didSet {
            NameLabel.text = "kListName".localized
        }
    }
    
    @IBOutlet weak var SurnameLabel: UILabel!{
        didSet {
            SurnameLabel.text = "kListSurname".localized
        }
    }
    
    
    
    
    @IBOutlet var stars: [UIButton]!
    
    
    static let kidentifier = "ListaCompagniCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

  
    }
    

  
    
   
    
}
