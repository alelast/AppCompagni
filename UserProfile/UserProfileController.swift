//
//  UserProfileController.swift
//  AppCompagniBanco
//
//  Created by Alessio Lasta on 18/10/18.
//  Copyright © 2018 Alessio Lasta. All rights reserved.
//
import UIKit

class UserProfileController: UIViewController {

    enum textFieldType : Int {
        case name = 0
        case surname
        case email
        case password
    }
    
    private var pickerController:UIImagePickerController?
    
    @IBOutlet weak var img: UIButton!
    
    @IBOutlet var textFields: [UITextField]! {
        didSet {
            for texts in textFields {
                switch texts.tag {
                case textFieldType.name.rawValue: texts.placeholder = "kUserName".localized
                     case textFieldType.surname.rawValue: texts.placeholder = "kUserSurname".localized
                     case textFieldType.email.rawValue: texts.placeholder = "kUserEmail".localized
                     case textFieldType.password.rawValue: texts.placeholder = "kUserPassword".localized
                default : break
                }
            }
        }
    }
    
    
    
    @IBOutlet weak var EditProfileButton: UIButton! {
        didSet {
            EditProfileButton.setTitle("kEditProfile".localized, for: .normal)
        }
    }
    
    @IBOutlet weak var GoLoginButton: UIButton!{
        didSet {
        GoLoginButton.setTitle("kUserProfileLogin".localized, for: .normal)
        }
    }
    
    
    var person : Persona = Persona()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in textFields {
            switch i.tag {
            case textFieldType.name.rawValue :
                i.text = person.name
            case textFieldType.surname.rawValue :
             i.text = person.surname
            case textFieldType.email.rawValue :
                i.text = person.email
            case textFieldType.password.rawValue :
                 i.text = person.password
            default : break
            }
   
        }
        
        // Carico immagine se è presente nel db
        
        if let imageProfile = person.image  {
            self.img.setImage(UIImage(data: imageProfile), for: .normal)
            
        } else {
              self.img.setImage(UIImage(named: "place"), for: .normal)
        }
    }
    

    @IBAction func AddPictureProfile(_ sender: UIButton) {
        self.pickerController = UIImagePickerController()
        self.pickerController!.delegate = self
        self.pickerController!.allowsEditing = true
        
        let alert = UIAlertController(title: nil, message: "Foto profilo", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Annulla", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        #if !targetEnvironment(simulator)
        let photo = UIAlertAction(title: "Scatta foto", style: .default) { action in
            self.pickerController!.sourceType = .camera
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        alert.addAction(photo)
        #endif
        
        let camera = UIAlertAction(title: "Carica foto", style: .default) { alert in
            self.pickerController!.sourceType = .photoLibrary
            self.present(self.pickerController!, animated: true, completion: nil)
        }
        alert.addAction(camera)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func ActionEditProfile(_ sender: UIButton) {
        
        var name : String!
        var surname : String!
        var password : String!
        var email : String!
        
        
        
                for i in textFields {
                    switch i.tag {
                    case textFieldType.name.rawValue :
                        name = i.text
                    case textFieldType.surname.rawValue :
                        surname = i.text
                    case textFieldType.email.rawValue :
                       email = i.text
                    case textFieldType.password.rawValue :
                        password = i.text
                    default : break
                    }
        
                }
        
        var image  = img.imageView?.image?.pngData()
        person.changeData(name: name, surname: surname, password: password, image: image, email: email)
        
        
        
   
//
//        self.performSegue(withIdentifier: "segueCompagni", sender: self)
    }
    
  // Torna al Login
    @IBAction func GoLogin(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueGoLogin", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "segueListaCompagni":
            if let destinationController = segue.destination as? ListaCompagniController {
                destinationController.person = person ?? Persona()
            }
        default:
            break
            
        }
    }

}
extension UserProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            debugPrint("No image found")
            return
        }
        
        let img2 = checkImageSizeAndResize(image: image)
        
        self.img.setImage(img2, for: .normal )
       
        self.dismiss(animated: true, completion: nil)
       
    }
    
    private func checkImageSizeAndResize(image : UIImage) -> UIImage {
        
        let imageSize: Int = image.pngData()!.count
        let imageDimension = Double(imageSize) / 1024.0 / 1024.0
        print("size of image in MB: ", imageDimension)
        
        if imageDimension > 15 {
            
            let img = image.resized(withPercentage: 0.5) ?? UIImage()
            
            
            return checkImageSizeAndResize(image: img)
            
        }
        
        return image
        
        
    }
    
}
