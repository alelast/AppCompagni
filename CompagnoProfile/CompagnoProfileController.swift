import UIKit

class CompagnoProfileController: UIViewController{
    
    enum TextFieldType : Int {
        case name = 0
        case surname
    }
    enum ButtonType : Int {
        case button1 = 0
        case button2
        case button3
        case button4
        case button5
    }
    
    
    @IBOutlet weak var SaveOutlet: UIButton! {
        didSet {
            SaveOutlet.setTitle("kCompagnoSave".localized, for: .normal)
        }
    }
    
    @IBOutlet weak var Img: UIButton!
    
    @IBOutlet var textFields: [UITextField]! {
        didSet {
            for texts in textFields {
                switch texts.tag {
                case TextFieldType.name.rawValue : texts.placeholder = "kCompagnoName".localized
                case TextFieldType.surname.rawValue : texts.placeholder = "kCompagnoSurname".localized
                default : break
                }
            }
        }
    }
    
    var name : String!
    var surname : String!
    var image : Data!
    var star1 : String!
    var star2 : String!
    var star3 : String!
    var star4 : String!
    var star5 : String!
    var stars : Int!
    
    @IBOutlet weak var nameLabel: UITextField!
    
    @IBOutlet weak var surnameLabel: UITextField!
    
    @IBOutlet  var buttonOutlets: [UIButton]!
    
    
    private var pickerController:UIImagePickerController?
    
    
    var compagno : Compagno?
    weak var delegate : CompagnoDelegate?
    private var empty : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*if(compagno.name == nil && compagno.surname == nil && compagno.image == nil){
            empty = true
        }
        else{
            empty = false
        }
        nameLabel.text = compagno.name
        surnameLabel.text = compagno.surname
        if let imageProfile = compagno.image {
            Img.setImage(UIImage(data: imageProfile), for: .normal)
        }
        
        
        
        
        if let stella1 = compagno.star1 {
            buttonOutlets[0].setTitle(stella1, for: .normal)
        }
        
        if let stella2 = compagno.star2{
            buttonOutlets[1].setTitle(stella2, for: .normal)
        }
        
        if let stella3 = compagno.star3{
           buttonOutlets[2].setTitle(stella3, for: .normal)
        }
        
        if let stella4 = compagno.star4{
          buttonOutlets[3].setTitle(stella4, for: .normal)
        }
        
        if let stella5 = compagno.star5{
            buttonOutlets[4].setTitle(stella5, for: .normal)
        }*/
        
        if compagno != nil{
            empty = false
            nameLabel.text = compagno?.getName()
            surnameLabel.text = compagno?.getSurname()
            if let imageProfile = compagno?.getImage() {
                Img.setImage(UIImage(data: imageProfile), for: .normal)
            }
            stars = Int((compagno?.getStars())!)
            for i in 0..<5 {
                
                switch buttonOutlets[i].tag {
                case 0:
                    if stars > 0{
                        buttonOutlets[i].setTitle("★", for: .normal)
                    }
                    else{
                        buttonOutlets[i].setTitle("☆", for: .normal)
                        
                    }
                    break
                case 1:
                    if stars > 1{
                        buttonOutlets[i].setTitle("★", for: .normal)
                    }
                    else{
                        buttonOutlets[i].setTitle("☆", for: .normal)
                        
                    }
                    break
                case 2:
                    if stars > 2{
                        buttonOutlets[i].setTitle("★", for: .normal)
                    }
                    else{
                        buttonOutlets[i].setTitle("☆", for: .normal)
                        
                    }
                    break
                case 3:
                    if stars > 3{
                        buttonOutlets[i].setTitle("★", for: .normal)
                    }
                    else{
                        buttonOutlets[i].setTitle("☆", for: .normal)
                        
                    }
                    break
                case 4:
                    if stars == 5{
                        buttonOutlets[i].setTitle("★", for: .normal)
                    }
                    else{
                        buttonOutlets[i].setTitle("☆", for: .normal)
                        
                    }
                    break
                default : break
                }
                
            }
            
            /*for i in stars..<5 {
                
                switch buttonOutlets[i].tag {
                case 0:
                    buttonOutlets[i].setTitle("☆", for: .normal)
                    break
                case 1:
                    buttonOutlets[i].setTitle("☆", for: .normal)
                    break
                case 2:
                    buttonOutlets[i].setTitle("☆", for: .normal)
                    break
                case 3:
                    buttonOutlets[i].setTitle("☆", for: .normal)
                    break
                case 4:
                    buttonOutlets[i].setTitle("☆", for: .normal)
                    break
                default : break
                }
                
            }*/
            
        }
        else{
            empty = true
        }
        
        
    }
    
    
    
    
    @IBAction func StarAction(_ sender: UIButton) {
        for btn in buttonOutlets {
            if(btn.tag <= sender.tag){
                btn.setTitle("★", for: .normal)
            }
            else {
                btn.setTitle("☆", for: .normal)
            }
        }
        
      
    }
    
    
    
    
    
    
    
    
    @IBAction func AddAction(_ sender: UIButton) {
        
        
        
        
        for i in 0..<textFields.count {
            
            switch textFields[i].tag {
            case TextFieldType.name.rawValue:
                name = textFields[i].text
                break
            case TextFieldType.surname.rawValue:
                surname = textFields[i].text
                break
            default : break
            }
            
        }
        image=Img.imageView?.image?.pngData()
        
        stars = 0
        for i in 0..<buttonOutlets.count {
            
            /*switch buttonOutlets[i].tag {
            case ButtonType.button1.rawValue:
                star1 = buttonOutlets[i].currentTitle
                break
            case ButtonType.button2.rawValue:
                star2 = buttonOutlets[i].currentTitle
                break
            case ButtonType.button3.rawValue:
                star3 = buttonOutlets[i].currentTitle
                break
            case ButtonType.button4.rawValue:
                star4 = buttonOutlets[i].currentTitle
                break
            case ButtonType.button5.rawValue:
                star5 = buttonOutlets[i].currentTitle
                break
                
            default : break
            }*/
            
            if buttonOutlets[i].currentTitle == "★"{
                stars+=1
            }
            
        }
        NSLog("Stelle lette = " + String(stars))
        
        
        
        //compagno = Compagno(name: name, surname: surname, image: image)
        
        guard (name != nil && !name!.isEmpty) || (surname != nil && !surname!.isEmpty) else {
            
            let alert = UIAlertController(title: "Attenzione", message: "O il Nome o il Cognome sono obbligatori", preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
            alert.addAction(okay)
            self.present(alert, animated: true, completion: nil)
            
            return }
        
        if(empty){
            //compagno = Compagno(name: name, surname: surname, image: image, star1: star1, star2: star2, star3: star3, star4: star4, star5: star5)
            compagno = Compagno(name: name, surname: surname, image: image, stars : String(stars))
            delegate?.addingCompagno(compagno: compagno!)
        }
        else{
            //delegate?.editCompagno(compagno: compagno,name: name,surname: surname,image: image, star1: star1, star2: star2, star3: star3, star4: star4, star5: star5)
            delegate?.editCompagno(compagno: compagno!,name: name,surname: surname,image: image, stars: String(stars))
        }
        
        navigationController?.popViewController(animated: true)
        
        
        
        
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
    
    
    
    
}
extension CompagnoProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            debugPrint("No image found")
            return
        }
        
        let img2 = checkImageSizeAndResize(image: image)
        
        self.Img.setImage(img2, for: .normal )
        
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
