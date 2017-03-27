//
//  FTPostViewController.swift
//  App_SocialFrameworks_Facebook_Twitter
//
//  Created by formador on 22/3/17.
//  Copyright © 2017 formador. All rights reserved.
//

import UIKit
import Social

class FTPostViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImagePost: UIImageView!
    @IBOutlet weak var myTextoPost: UILabel!
    
    //MARK: - IBActions
    @IBAction func postFacebookACTION(_ sender: Any) {
        //1 -> comprobamos la disponibilidad del framework
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
            //2 -> creamos el objeto
            let postFacebookData = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            postFacebookData?.setInitialText(myTextoPost.text!)
            postFacebookData?.add(myImagePost.image!)
            postFacebookData?.add(URL(string: "http://www.andresocampo.com"))
            present(postFacebookData!, animated: true, completion: nil)
            
            limpiarDatos()
            
        }else{
            present(muestraAlertVC("Estimado usuario",
                                   messageData:"La cuenta de Facebook no esta disponible" ,
                                   titleAction: "OK"),
                    animated: true,
                    completion: nil)
        }
    }
    
    @IBAction func postTwitterACTION(_ sender: Any) {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            //2 -> creamos el objeto
            let postFacebookData = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            postFacebookData?.setInitialText(myTextoPost.text!)
            //postFacebookData?.add(myImagePost.image!)
            postFacebookData?.add(URL(string: "http://www.andresocampo.com"))
            present(postFacebookData!, animated: true, completion: nil)
            
            limpiarDatos()
            
        }else{
            present(muestraAlertVC("Estimado usuario",
                                   messageData:"La cuenta de Twitter no esta disponible" ,
                                   titleAction: "OK"),
                    animated: true,
                    completion: nil)
        }
    }
    
    @IBAction func showPickerPhoto(_ sender: Any) {
        pickerPhoto()
    }
    
    @IBAction func showActivitiesSheetACTION(_ sender: Any) {
        
        //let myModel = model[sender.tag].nombreid
        let textoCompartir = myTextoPost.text
        let webCompartir = "http://www.andresocampo.com"
        //let imagenCompartir = myImagePost.image
        let compartirAVC = UIActivityViewController(activityItems: [textoCompartir!, webCompartir], applicationActivities: nil)
        present(compartirAVC, animated: true, completion: nil)
        limpiarDatos()
    }
    
    @IBAction func showNewComentaryACTION(_ sender: Any) {
        present(muestraAlertVC("Estimado usuario",
                               messageData:"Esto es un nuevo comentario" ,
                               titleAction: "OK"),
                animated: true,
                completion: nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Utils
    func limpiarDatos(){
        myTextoPost.text = ""
        myImagePost.image = #imageLiteral(resourceName: "placehoder")
    }

    
}//TODO: - Fin de la clase


extension FTPostViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func pickerPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        }else{
            muestraLibreriaFotos()
        }
    }
    
    func muestraMenu(){
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let tomaFotoAction = UIAlertAction(title: "Toma Foto", style: .default) { _ in
            self.muestraCamara()
        }
        let seleccionaLibreriaAction = UIAlertAction(title: "Selecciona de la Librería", style: .default) { _ in
            self.muestraLibreriaFotos()
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(tomaFotoAction)
        alertVC.addAction(seleccionaLibreriaAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func muestraCamara(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func muestraLibreriaFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImagePost.image = imageData
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}



