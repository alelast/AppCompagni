//
//  RegisterViewController.swift
//  AppCompagniBanco
//
//  Created by Alessio Lasta on 18/10/18.
//  Copyright © 2018 Alessio Lasta. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    enum TextFieldsType : Int{
        case name = 0
        case surname
        case email
        case password
        case password2
    }
    enum LabelFieldsType : Int{
        case name = 0
        case surname
        case email
        case password
        case password2
    }
    //private var listPerson : [Persona]!
    
    private var userRegistered : Persona?
    
    
    
    @IBOutlet var labelCollection: [UILabel]!{
        didSet {
            for labels in labelCollection {
                switch labels.tag {
                case LabelFieldsType.name.rawValue : labels.text = "kSignUpName".localized
                case LabelFieldsType.surname.rawValue : labels.text = "kSignUpSurname".localized
                case LabelFieldsType.email.rawValue : labels.text = "kSignUpEmail".localized
                case LabelFieldsType.password.rawValue : labels.text = "kSignUpPassword".localized
                case LabelFieldsType.password2.rawValue : labels.text = "kSignUpRepeatPassword".localized
                    
                default : break
                }
            }
        }
    }
    
    
    
    
    
    
    @IBOutlet var registerCollection: [UITextField]! {
        didSet {
            for placeholders in registerCollection {
                switch placeholders.tag {
                case TextFieldsType.name.rawValue : placeholders.placeholder = "kSignUpName".localized
                    case TextFieldsType.surname.rawValue : placeholders.placeholder = "kSignUpSurname".localized
                    case TextFieldsType.email.rawValue : placeholders.placeholder = "kSignUpEmail".localized
                    case TextFieldsType.password.rawValue : placeholders.placeholder = "kSignUpPassword".localized
                    case TextFieldsType.password2.rawValue : placeholders.placeholder = "kSignUpRepeatPassword".localized
                    
                default : break
                }
            }
        }
    }
    
    
    @IBOutlet weak var registerOutlet: UIButton! {
        didSet {
            registerOutlet.setTitle("kSignUpRegisterButton".localized, for: .normal)
        }
    }
    
    @IBOutlet weak var loginOutlet: UIButton! {
        didSet {
            loginOutlet.setTitle("kSignUpLoginButton".localized, for: .normal)
        }
    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func registerActionButton(_ sender: UIButton) {
        for tag in 0...4 {
            NSLog("tag: "+String(tag))
            guard registerCollection[tag].text != "" else{
                myAlert("Empty fields")
                NSLog("campi vuoti")
                return
            }
        }
        NSLog("campi non vuoti")
        var pw : String!
        pw = registerCollection[TextFieldsType.password.rawValue].text
        guard pw == registerCollection[TextFieldsType.password2.rawValue].text else{
            myAlert("Different emails")
            NSLog("password diverse")
            return
        }
        NSLog("password uguali")
        guard pw.count > 5 else{
            myAlert("Password must have almost 6 characters")
            NSLog("password minore di 6 car")
            return
        }
        NSLog("password.count OK!")
        let email : String! = registerCollection[TextFieldsType.email.rawValue].text
        let pDB = Persona.readUser(withid: email)
        /*for persona in listPerson {
            guard persona.email != email else{
                myAlert("Existing email")
                NSLog("email già esistente")
                return
            }
            
        }*/
        guard (pDB == nil) else{
            myAlert("Existing email")
            NSLog("email già esistente")
            return
        }
        guard isValidEmail(testStr: email) else{
            myAlert("Invalid email")
            NSLog("Email non valida!")
            return
        }
        NSLog("email non esistente")
        userRegistered = Persona(name: registerCollection[TextFieldsType.name.rawValue].text, surname: registerCollection[TextFieldsType.surname.rawValue].text, password: registerCollection[TextFieldsType.password.rawValue].text, email: registerCollection[TextFieldsType.email.rawValue].text)
        
        userRegistered?.add()
        
        NSLog("Salvato, registrato!")
        
        self.performSegue(withIdentifier: "segueUserProfile", sender: self.dismiss)
        
        //a
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //listPerson = Persona.all()
        
        
    }
    
    
   
    @IBAction func GoLogin(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "segueLogin", sender: self.dismiss)
        
    }
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func myAlert(_ text : String!){
        let alert = UIAlertController(title: "Attention", message: text, preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        alert.addAction(okay)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "segueUserProfile":
            if let destinationController = segue.destination as? UserProfileController {
                destinationController.person =  userRegistered ?? Persona()
            }
        default:
            break
    }
}
}
