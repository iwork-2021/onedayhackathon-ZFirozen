//
//  ViewController.swift
//  Image Drawer
//
//  Created by ZFirozen on 2021/12/21.
//

import UIKit
import CoreML
import Vision
import CoreMedia

protocol ImagePickerDelegate {
    func imageSelected(newImage: UIImage)
}

class ZPickerViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    var pickerType: UIImagePickerController.SourceType = .photoLibrary
    var imagePickerDelegate: ImagePickerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        doneButton.isEnabled = (self.imageView.image != nil)
        presentPhotoPicker(sourceType: pickerType)
    }
    
    func presentPhotoPicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        present(picker, animated: true)
    }

    @IBAction func doneButtonPressed(_ sender: Any) {
        self.imagePickerDelegate?.imageSelected(newImage: self.imageView.image!)
        navigationController?.popViewController(animated: true)
    }
}

extension ZPickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        let image = info[.originalImage] as! UIImage
        imageView.image = image
        doneButton.isEnabled = (self.imageView.image != nil)
    }
}

