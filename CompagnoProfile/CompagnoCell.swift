//
//  CompagnoCell.swift
//  LoginxCasa
//
//  Created by Valerio Ly on 19/10/18.
//  Copyright © 2018 Valerio Ly. All rights reserved.
//

import UIKit

class CompagnoCell: UITableViewCell {
    
    enum TextFieldType : Int {
        case name = 0
        case surname
    
    }
    
    @IBOutlet weak var Img: UIButton!
    
    @IBOutlet var textFields: [UITextField]!
    
    private var editingCompagno : Compagno! //
    
    weak var delegate: CompagnoDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    @IBAction func SaveAction(_ sender: UIButton) {
        
        
    }
    func setup(withObject object : Compagno) {
        
      
//     editingCompagno = object
        
        for textField in textFields {
            switch textField.tag {
            case TextFieldType.name.rawValue:
                textField.text = object.name
            case TextFieldType.surname.rawValue:
                textField.text = object.surname
            default:
                break
            }
        }
        
        if let imageProfile = object.image {
            self.Img.setImage(UIImage(data: imageProfile), for: .normal)
        } else {
            self.Img.setImage(UIImage(named: "place"), for: .normal)
        }
        
       
        
    }
   
    @IBAction func ActionTextFields(_ sender: UITextField) {
        
        switch sender.tag {
        case TextFieldType.name.rawValue:
            editingCompagno.changeData(name: sender.text)
        case TextFieldType.surname.rawValue:
            editingCompagno.changeData(surname : sender.text)
        default:
            break
        }

    }
    
    
}
